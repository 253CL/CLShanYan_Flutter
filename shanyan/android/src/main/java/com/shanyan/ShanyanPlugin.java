package com.shanyan;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.chuanglan.shanyan_sdk.OneKeyLoginManager;
import com.chuanglan.shanyan_sdk.listener.AuthenticationExecuteListener;
import com.chuanglan.shanyan_sdk.listener.GetPhoneInfoListener;
import com.chuanglan.shanyan_sdk.listener.InitListener;
import com.chuanglan.shanyan_sdk.listener.OnClickPrivacyListener;
import com.chuanglan.shanyan_sdk.listener.OneKeyLoginListener;
import com.chuanglan.shanyan_sdk.listener.OpenLoginAuthListener;
import com.chuanglan.shanyan_sdk.listener.ShanYanCustomInterface;
import com.chuanglan.shanyan_sdk.tool.ShanYanUIConfig;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * MyFlutterPlugin
 */
public class ShanyanPlugin implements MethodCallHandler {

    // 定义日志 TAG
    private static final String TAG = "|shanyan_flutter======|";
    final String shanyan_code = "code";
    final String shanyan_result = "result";
    final String shanyan_operator = "operator";
    final String shanyan_widgetLayoutId = "widgetLayoutId";
    final String shanyan_widgetId = "widgetId";
    private MethodChannel channel;
    /**
     * Plugin registration.
     */
    private Context context;

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "shanyan");
        channel.setMethodCallHandler(new ShanyanPlugin(registrar, channel));

    }

    private ShanyanPlugin(Registrar registrar, MethodChannel channel) {
        this.context = registrar.context();
        this.channel = channel;
    }

    @Override
    public void onMethodCall(MethodCall call, final Result result) {
        if (call.method.equals("setDebugMode")) {
            //闪验SDK 设置debug模式
            setDebug(call);
        } else if (call.method.equals("init")) {
            //闪验SDK 初始化
            init(call, result);
        } else if (call.method.equals("getPhoneInfo")) {
            //闪验SDK 预取号
            getPhoneInfo(result);
        } else if (call.method.equals("setAuthThemeConfig")) {
            setAuthThemeConfig(call, result);
        } else if (call.method.equals("openLoginAuth")) {
            //闪验SDK 拉起授权页
            openLoginAuth(call, result);
        } else if (call.method.equals("finishAuthActivity")) {
            OneKeyLoginManager.getInstance().finishAuthActivity();
        } else if (call.method.equals("setOnClickPrivacyListener")) {
            setOnClickPrivacyListener();
        } else if (call.method.equals("getPreIntStatus")) {
            result.success(OneKeyLoginManager.getInstance().getPreIntStatus());
        } else if (call.method.equals("getOperatorType")) {
            result.success(OneKeyLoginManager.getInstance().getOperatorType(context));
        } else if (call.method.equals("startAuthentication")) {
            startAuthentication(call, result);
        }


    }

    private void startAuthentication(MethodCall call, final Result result) {
        String phoneNum = call.argument("phoneNum");
        OneKeyLoginManager.getInstance().startAuthentication(phoneNum, new AuthenticationExecuteListener() {
            @Override
            public void authenticationRespond(int code, String msg) {
                Map<String, Object> map = new HashMap<>();
                map.put(shanyan_code, code);
                map.put(shanyan_result, msg);
                result.success(map);
            }
        });
    }

    private void setOnClickPrivacyListener() {
        OneKeyLoginManager.getInstance().setOnClickPrivacyListener(new OnClickPrivacyListener() {
            @Override
            public void getOnClickPrivacyStatus(int i, String s, String s1) {
                Map<String, Object> map = new HashMap<>();
                map.put(shanyan_code, i);
                map.put(shanyan_result, s);
                map.put(shanyan_operator, s1);
                channel.invokeMethod("onReceiveAuthPageEvent", map);
            }
        });
    }

    private void openLoginAuth(MethodCall call, final Result result) {
        boolean isFinish = call.argument("isFinish");
        //闪验SDK 拉起授权页
        OneKeyLoginManager.getInstance().openLoginAuth(isFinish, new OpenLoginAuthListener() {
            @Override
            public void getOpenLoginAuthStatus(int code, String msg) {
                //授权页是否拉起成功回调
                Map<String, Object> map = new HashMap<>();
                map.put(shanyan_code, code);
                map.put(shanyan_result, msg);
                result.success(map);
            }
        }, new OneKeyLoginListener() {
            @Override
            public void getOneKeyLoginStatus(int code, String msg) {
                //点击授权页“一键登录”按钮或者返回键（包括物理返回键）回调
                Map<String, Object> map = new HashMap<>();
                map.put(shanyan_code, code);
                map.put(shanyan_result, msg);
                channel.invokeMethod("onReceiveAuthPageEvent", map);
            }
        });
    }

    private void getPhoneInfo(final Result result) {
        OneKeyLoginManager.getInstance().getPhoneInfo(new GetPhoneInfoListener() {
            @Override
            public void getPhoneInfoStatus(int code, String msg) {
                Map<String, Object> map = new HashMap<>();
                map.put(shanyan_code, code);
                map.put(shanyan_result, msg);
                result.success(map);
            }
        });
    }

    private void init(MethodCall call, final Result result) {
        String appId = call.argument("appId");
        OneKeyLoginManager.getInstance().init(context, appId, new InitListener() {
            @Override
            public void getInitStatus(int code, String msg) {
                Map<String, Object> map = new HashMap<>();
                map.put(shanyan_code, code);
                map.put(shanyan_result, msg);
                result.success(map);
            }
        });
    }

    private void setDebug(MethodCall call) {
        boolean debug = call.argument("debug");
        OneKeyLoginManager.getInstance().setDebug(debug);
    }

    private void setAuthThemeConfig(MethodCall call, Result result) {
        Map uiConfig = call.argument("uiConfig");
        List<Map> widgetList = call.argument("widgets");
        List<Map> widgetLayoutList = call.argument("widgetLayout");
        ShanYanUIConfig.Builder builder = new ShanYanUIConfig.Builder();
        setAuthLayoutView(uiConfig, builder);
        if (null != widgetList) {
            for (Map widgetMap : widgetList) {
                /// 新增自定义的控件
                String type = (String) widgetMap.get("type");
                if (type.equals("TextView")) {
                    addCustomTextWidgets(widgetMap, builder);
                } else {
                    Log.e(TAG, "don't support widget");
                }
            }
        }
        if (null != widgetLayoutList) {
            for (Map widgetMap : widgetLayoutList) {
                /// 新增自定义的控件
                String type = (String) widgetMap.get("type");
                if (type.equals("RelativeLayout")) {
                    addCustomRelativeLayoutWidgets(widgetMap, builder);
                } else {
                    Log.e(TAG, "don't support widgetlayout");
                }
            }
        }
        ShanYanUIConfig shanYanUIConfig = builder.build();
        OneKeyLoginManager.getInstance().setAuthThemeConfig(shanYanUIConfig);
    }

    /**
     * 添加自定义xml布局文件
     */
    private void addCustomRelativeLayoutWidgets(Map para, ShanYanUIConfig.Builder builder) {
        Log.d(TAG, "addCustomRelativeLayoutWidgets: para = " + para);
        String widgetLayoutName = (String) para.get("widgetLayoutName");
        Object widgetId = para.get("widgetLayoutId");
        int left = (Integer) para.get("left");
        int top = (Integer) para.get("top");
        int right = (Integer) para.get("right");
        int bottom = (Integer) para.get("bottom");
        int width = (Integer) para.get("width");
        int height = (Integer) para.get("height");
        LayoutInflater inflater1 = LayoutInflater.from(context);
        if (0 != getLayoutForId(widgetLayoutName)) {
            RelativeLayout relativeLayout = (RelativeLayout) inflater1.inflate(getLayoutForId(widgetLayoutName), null);
            RelativeLayout.LayoutParams mLayoutParams1 = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
            mLayoutParams1.addRule(RelativeLayout.CENTER_HORIZONTAL);
            if (left > 0) {
                mLayoutParams1.leftMargin = dp2Pix(context, (float) left);
                mLayoutParams1.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
            }
            if (top > 0) {
                mLayoutParams1.topMargin = dp2Pix(context, (float) top);
            }
            if (right > 0) {
                mLayoutParams1.rightMargin = dp2Pix(context, (float) right);
                mLayoutParams1.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
            }
            if (bottom > 0) {
                mLayoutParams1.bottomMargin = dp2Pix(context, (float) bottom);
                mLayoutParams1.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
            }
            if (width > 0) {
                mLayoutParams1.width = dp2Pix(context, (float) width);
            }
            if (height > 0) {
                mLayoutParams1.height = dp2Pix(context, (float) height);
                ;
            }
            if (null != relativeLayout) {
                relativeLayout.setLayoutParams(mLayoutParams1);
                //授权页 隐私协议栏
                if (null != widgetId) {
                    ArrayList<String> widgetIdList = (ArrayList) widgetId;
                    widgetIdList.addAll(Arrays.asList("", "", "", "", ""));
                    for (int i = 0; i < 5; i++) {
                        switch (i) {
                            case 0:
                                final Map<String, Object> jsonMap = new HashMap<>();
                                jsonMap.put(shanyan_widgetLayoutId, widgetIdList.get(i));
                                if (0 != (getId(widgetIdList.get(i)))) {
                                    relativeLayout.findViewById(getId(widgetIdList.get(i))).setOnClickListener(new View.OnClickListener() {
                                        @Override
                                        public void onClick(View v) {
                                            channel.invokeMethod("onReceiveClickWidgetLayoutEvent", jsonMap);
                                        }
                                    });
                                }
                                break;
                            case 1:
                                final Map<String, Object> jsonMap1 = new HashMap<>();
                                jsonMap1.put(shanyan_widgetLayoutId, widgetIdList.get(i));
                                if (0 != (getId(widgetIdList.get(i)))) {
                                    relativeLayout.findViewById(getId(widgetIdList.get(i))).setOnClickListener(new View.OnClickListener() {
                                        @Override
                                        public void onClick(View v) {
                                            channel.invokeMethod("onReceiveClickWidgetLayoutEvent", jsonMap1);
                                        }
                                    });
                                }
                                break;
                            case 2:
                                final Map<String, Object> jsonMap2 = new HashMap<>();
                                jsonMap2.put(shanyan_widgetLayoutId, widgetIdList.get(i));
                                if (0 != (getId(widgetIdList.get(i)))) {
                                    relativeLayout.findViewById(getId(widgetIdList.get(i))).setOnClickListener(new View.OnClickListener() {
                                        @Override
                                        public void onClick(View v) {
                                            channel.invokeMethod("onReceiveClickWidgetLayoutEvent", jsonMap2);
                                        }
                                    });
                                }
                                break;
                            case 3:
                                final Map<String, Object> jsonMap3 = new HashMap<>();
                                jsonMap3.put(shanyan_widgetLayoutId, widgetIdList.get(i));
                                if (0 != (getId(widgetIdList.get(i)))) {
                                    relativeLayout.findViewById(getId(widgetIdList.get(i))).setOnClickListener(new View.OnClickListener() {
                                        @Override
                                        public void onClick(View v) {
                                            channel.invokeMethod("onReceiveClickWidgetLayoutEvent", jsonMap3);
                                        }
                                    });
                                }
                                break;
                            case 4:
                                final Map<String, Object> jsonMap4 = new HashMap<>();
                                jsonMap4.put(shanyan_widgetLayoutId, widgetIdList.get(i));
                                if (0 != (getId(widgetIdList.get(i)))) {
                                    relativeLayout.findViewById(getId(widgetIdList.get(i))).setOnClickListener(new View.OnClickListener() {
                                        @Override
                                        public void onClick(View v) {
                                            channel.invokeMethod("onReceiveClickWidgetLayoutEvent", jsonMap4);
                                        }
                                    });
                                }
                                break;
                        }

                    }
                }
                builder.addCustomView(relativeLayout, false, false, null);
            }
        } else {
            Log.d(TAG, "layout【" + widgetLayoutName + "】 not found!");
        }
    }

    /**
     * 添加自定义 TextView
     */
    private void addCustomTextWidgets(Map para, ShanYanUIConfig.Builder builder) {
        Log.d(TAG, "addCustomTextView " + para);
        String widgetId = (String) para.get("widgetId");
        int left = (Integer) para.get("left");
        int top = (Integer) para.get("top");
        int right = (Integer) para.get("right");
        int bottom = (Integer) para.get("bottom");
        int width = (Integer) para.get("width");
        int height = (Integer) para.get("height");
        String textContent = (String) para.get("textContent");
        Object font = para.get("textFont");
        Object textColor = para.get("textColor");
        Object backgroundColor = para.get("backgroundColor");
        Object backgroundImgPath = para.get("backgroundImgPath");
        Object alignmet = para.get("textAlignment");
        boolean isFinish = (Boolean) para.get("isFinish");
        TextView customView = new TextView(context);
        customView.setText(textContent);
        if (textColor != null) {
            customView.setTextColor(Color.parseColor((String) textColor));
        }
        if (font != null) {
            double titleFont = (double) font;
            if (titleFont > 0) {
                customView.setTextSize((float) titleFont);
            }
        }
        if (backgroundColor != null) {
            customView.setBackgroundColor(Color.parseColor((String) backgroundColor));
        }
        if (null != getDrawableByReflect(backgroundImgPath)) {
            customView.setBackground(getDrawableByReflect(backgroundImgPath));
        }
        if (alignmet != null) {
            String textAlignment = (String) alignmet;
            int gravity = getAlignmentFromString(textAlignment);
            customView.setGravity(gravity);
        }
        RelativeLayout.LayoutParams mLayoutParams1 = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
        mLayoutParams1.addRule(RelativeLayout.CENTER_HORIZONTAL);
        if (left > 0) {
            mLayoutParams1.leftMargin = dp2Pix(context, (float) left);
            mLayoutParams1.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
        }
        if (top > 0) {
            mLayoutParams1.topMargin = dp2Pix(context, (float) top);
        }
        if (right > 0) {
            mLayoutParams1.rightMargin = dp2Pix(context, (float) right);
            mLayoutParams1.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
        }
        if (bottom > 0) {
            mLayoutParams1.bottomMargin = dp2Pix(context, (float) bottom);
            mLayoutParams1.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
        }
        if (width > 0) {
            mLayoutParams1.width = dp2Pix(context, (float) width);
        }
        if (height > 0) {
            mLayoutParams1.height = dp2Pix(context, (float) height);
            ;
        }
        customView.setLayoutParams(mLayoutParams1);
        final HashMap jsonMap = new HashMap();
        jsonMap.put(shanyan_widgetId, widgetId);
        builder.addCustomView(customView, isFinish, false, new ShanYanCustomInterface() {
            @Override
            public void onClick(Context context, View view) {
                channel.invokeMethod("onReceiveClickWidgetEvent", jsonMap);
            }
        });
    }

    private void setAuthLayoutView(Map shanYanUIConfig, ShanYanUIConfig.Builder builder) {
        Log.d(TAG, "shanYanUIConfig " + shanYanUIConfig);
        Object setAuthBGImgPath = valueForKey(shanYanUIConfig, "setAuthBGImgPath");
        Object setAuthBgGifPath = valueForKey(shanYanUIConfig, "setAuthBgGifPath");
        Object setAuthBgVideoPath = valueForKey(shanYanUIConfig, "setAuthBgVideoPath");
        Object setFullScreen = valueForKey(shanYanUIConfig, "setFullScreen");
        Object setNavColor = valueForKey(shanYanUIConfig, "setNavColor");
        Object setNavText = valueForKey(shanYanUIConfig, "setNavText");
        Object setNavTextColor = valueForKey(shanYanUIConfig, "setNavTextColor");
        Object setNavTextSize = valueForKey(shanYanUIConfig, "setNavTextSize");
        Object setNavReturnImgPath = valueForKey(shanYanUIConfig, "setNavReturnImgPath");
        Object setNavReturnImgHidden = valueForKey(shanYanUIConfig, "setNavReturnImgHidden");
        Object setNavReturnBtnWidth = valueForKey(shanYanUIConfig, "setNavReturnBtnWidth");
        Object setNavReturnBtnHeight = valueForKey(shanYanUIConfig, "setNavReturnBtnHeight");
        Object setNavReturnBtnOffsetRightX = valueForKey(shanYanUIConfig, "setNavReturnBtnOffsetRightX");
        Object setNavReturnBtnOffsetX = valueForKey(shanYanUIConfig, "setNavReturnBtnOffsetX");
        Object setNavReturnBtnOffsetY = valueForKey(shanYanUIConfig, "setNavReturnBtnOffsetY");
        Object setAuthNavHidden = valueForKey(shanYanUIConfig, "setAuthNavHidden");
        Object setAuthNavTransparent = valueForKey(shanYanUIConfig, "setAuthNavTransparent");
        Object setLogoImgPath = valueForKey(shanYanUIConfig, "setLogoImgPath");
        Object setLogoWidth = valueForKey(shanYanUIConfig, "setLogoWidth");
        Object setLogoHeight = valueForKey(shanYanUIConfig, "setLogoHeight");
        Object setLogoOffsetY = valueForKey(shanYanUIConfig, "setLogoOffsetY");
        Object setLogoOffsetBottomY = valueForKey(shanYanUIConfig, "setLogoOffsetBottomY");
        Object setLogoHidden = valueForKey(shanYanUIConfig, "setLogoHidden");
        Object setLogoOffsetX = valueForKey(shanYanUIConfig, "setLogoOffsetX");
        Object setNumberColor = valueForKey(shanYanUIConfig, "setNumberColor");
        Object setNumFieldOffsetY = valueForKey(shanYanUIConfig, "setNumFieldOffsetY");
        Object setNumFieldOffsetBottomY = valueForKey(shanYanUIConfig, "setNumFieldOffsetBottomY");
        Object setNumFieldWidth = valueForKey(shanYanUIConfig, "setNumFieldWidth");
        Object setNumFieldHeight = valueForKey(shanYanUIConfig, "setNumFieldHeight");
        Object setNumberSize = valueForKey(shanYanUIConfig, "setNumberSize");
        Object setNumFieldOffsetX = valueForKey(shanYanUIConfig, "setNumFieldOffsetX");
        Object setLogBtnText = valueForKey(shanYanUIConfig, "setLogBtnText");
        Object setLogBtnTextColor = valueForKey(shanYanUIConfig, "setLogBtnTextColor");
        Object setLogBtnImgPath = valueForKey(shanYanUIConfig, "setLogBtnImgPath");
        Object setLogBtnOffsetY = valueForKey(shanYanUIConfig, "setLogBtnOffsetY");
        Object setLogBtnOffsetBottomY = valueForKey(shanYanUIConfig, "setLogBtnOffsetBottomY");
        Object setLogBtnTextSize = valueForKey(shanYanUIConfig, "setLogBtnTextSize");
        Object setLogBtnHeight = valueForKey(shanYanUIConfig, "setLogBtnHeight");
        Object setLogBtnWidth = valueForKey(shanYanUIConfig, "setLogBtnWidth");
        Object setLogBtnOffsetX = valueForKey(shanYanUIConfig, "setLogBtnOffsetX");
        Object setAppPrivacyOne = valueForKey(shanYanUIConfig, "setAppPrivacyOne");
        Object setAppPrivacyTwo = valueForKey(shanYanUIConfig, "setAppPrivacyTwo");
        Object setAppPrivacyThree = valueForKey(shanYanUIConfig, "setAppPrivacyThree");
        Object setPrivacySmhHidden = valueForKey(shanYanUIConfig, "setPrivacySmhHidden");
        Object setPrivacyTextSize = valueForKey(shanYanUIConfig, "setPrivacyTextSize");
        Object setAppPrivacyColor = valueForKey(shanYanUIConfig, "setAppPrivacyColor");
        Object setPrivacyOffsetBottomY = valueForKey(shanYanUIConfig, "setPrivacyOffsetBottomY");
        Object setPrivacyOffsetY = valueForKey(shanYanUIConfig, "setPrivacyOffsetY");
        Object setPrivacyOffsetX = valueForKey(shanYanUIConfig, "setPrivacyOffsetX");
        Object setPrivacyOffsetGravityLeft = valueForKey(shanYanUIConfig, "setPrivacyOffsetGravityLeft");
        Object setPrivacyState = valueForKey(shanYanUIConfig, "setPrivacyState");
        Object setUncheckedImgPath = valueForKey(shanYanUIConfig, "setUncheckedImgPath");
        Object setCheckedImgPath = valueForKey(shanYanUIConfig, "setCheckedImgPath");
        Object setCheckBoxHidden = valueForKey(shanYanUIConfig, "setCheckBoxHidden");
        Object setCheckBoxWH = valueForKey(shanYanUIConfig, "setCheckBoxWH");
        Object setCheckBoxMargin = valueForKey(shanYanUIConfig, "setCheckBoxMargin");
        Object setPrivacyText = valueForKey(shanYanUIConfig, "setPrivacyText");
        Object setSloganTextColor = valueForKey(shanYanUIConfig, "setSloganTextColor");
        Object setSloganTextSize = valueForKey(shanYanUIConfig, "setSloganTextSize");
        Object setSloganOffsetY = valueForKey(shanYanUIConfig, "setSloganOffsetY");
        Object setSloganHidden = valueForKey(shanYanUIConfig, "setSloganHidden");
        Object setSloganOffsetBottomY = valueForKey(shanYanUIConfig, "setSloganOffsetBottomY");
        Object setSloganOffsetX = valueForKey(shanYanUIConfig, "setSloganOffsetX");
        Object setLoadingView = valueForKey(shanYanUIConfig, "setLoadingView");
        Object setDialogTheme = valueForKey(shanYanUIConfig, "setDialogTheme");
        if (0 != getLayoutForId((String) setLoadingView)) {
            RelativeLayout.LayoutParams mLayoutParams3 = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT);
            RelativeLayout view_dialog = (RelativeLayout) LayoutInflater.from(context).inflate(getLayoutForId((String) setLoadingView), null);
            view_dialog.setLayoutParams(mLayoutParams3);
            builder.setLoadingView(view_dialog);
        }
        //授权页背景
        if (null != getDrawableByReflect(setAuthBGImgPath)) {
            builder.setAuthBGImgPath(getDrawableByReflect(setAuthBGImgPath));
        }
        if (null != setAuthBgGifPath) {
            builder.setAuthBgGifPath((String) setAuthBgGifPath);
        }
        if (null != setAuthBgVideoPath) {
            builder.setAuthBgVideoPath((String) setAuthBgVideoPath);
        }
        //导航栏
        if (null != setFullScreen) {
            builder.setFullScreen((Boolean) setFullScreen);
        }
        if (null != setNavColor) {
            builder.setNavColor(Color.parseColor((String) setNavColor));
        }
        if (null != setNavText) {
            builder.setNavText((String) setNavText);
        }
        if (null != setNavTextColor) {
            builder.setNavTextColor(Color.parseColor((String) setNavTextColor));
        }
        if (null != setNavTextSize) {
            builder.setNavTextSize((Integer) setNavTextSize);
        }
        if (null != setNavReturnImgPath) {
            builder.setNavReturnImgPath(getDrawableByReflect(setNavReturnImgPath));
        }
        if (null != setNavReturnImgHidden) {
            builder.setNavReturnImgHidden((Boolean) setNavReturnImgHidden);
        }
        if (null != setNavReturnBtnWidth) {
            builder.setNavReturnBtnWidth((Integer) setNavReturnBtnWidth);
        }
        if (null != setNavReturnBtnHeight) {
            builder.setNavReturnBtnHeight((Integer) setNavReturnBtnHeight);
        }
        if (null != setNavReturnBtnOffsetRightX) {
            builder.setNavReturnBtnOffsetRightX((Integer) setNavReturnBtnOffsetRightX);
        }
        if (null != setNavReturnBtnOffsetX) {
            builder.setNavReturnBtnOffsetX((Integer) setNavReturnBtnOffsetX);
        }
        if (null != setNavReturnBtnOffsetY) {
            builder.setNavReturnBtnOffsetY((Integer) setNavReturnBtnOffsetY);
        }
        if (null != setAuthNavHidden) {
            builder.setAuthNavHidden((Boolean) setAuthNavHidden);
        }
        if (null != setAuthNavTransparent) {
            builder.setAuthNavTransparent((Boolean) setAuthNavTransparent);
        }
        // 授权页logo
        if (null != setLogoImgPath) {
            builder.setLogoImgPath(getDrawableByReflect(setLogoImgPath));
        }
        if (null != setLogoWidth) {
            builder.setLogoWidth((Integer) setLogoWidth);
        }
        if (null != setLogoHeight) {
            builder.setLogoHeight((Integer) setLogoHeight);
        }
        if (null != setLogoOffsetY) {
            builder.setLogoOffsetY((Integer) setLogoOffsetY);
        }
        if (null != setLogoOffsetBottomY) {
            builder.setLogoOffsetBottomY((Integer) setLogoOffsetBottomY);
        }
        if (null != setLogoHidden) {
            builder.setLogoHidden((Boolean) setLogoHidden);
        }
        if (null != setLogoOffsetX) {
            builder.setLogoOffsetX((Integer) setLogoOffsetX);
        }
        // 授权页 号码栏
        if (null != setNumberColor) {
            builder.setNumberColor(Color.parseColor((String) setNumberColor));
        }
        if (null != setNumFieldOffsetY) {
            builder.setNumFieldOffsetY((Integer) setNumFieldOffsetY);
        }
        if (null != setNumFieldOffsetBottomY) {
            builder.setNumFieldOffsetBottomY((Integer) setNumFieldOffsetBottomY);
        }
        if (null != setNumFieldWidth) {
            builder.setNumFieldWidth((Integer) setNumFieldWidth);
        }
        if (null != setNumFieldHeight) {
            builder.setNumFieldHeight((Integer) setNumFieldHeight);
        }
        if (null != setNumberSize) {
            builder.setNumberSize((Integer) setNumberSize);
        }
        if (null != setNumFieldOffsetX) {
            builder.setNumFieldOffsetX((Integer) setNumFieldOffsetX);
        }
        //授权页 登录按钮

        if (null != setLogBtnText) {
            builder.setLogBtnText((String) setLogBtnText);
        }
        if (null != setLogBtnTextColor) {
            builder.setLogBtnTextColor(Color.parseColor((String) setLogBtnTextColor));
        }
        if (null != setLogBtnImgPath) {
            builder.setLogBtnImgPath(getDrawableByReflect(setLogBtnImgPath));
        }
        if (null != setLogBtnOffsetY) {
            builder.setLogBtnOffsetY((Integer) setLogBtnOffsetY);
        }
        if (null != setLogBtnOffsetBottomY) {
            builder.setLogBtnOffsetBottomY((Integer) setLogBtnOffsetBottomY);
        }
        if (null != setLogBtnTextSize) {
            builder.setLogBtnTextSize((Integer) setLogBtnTextSize);
        }
        if (null != setLogBtnHeight) {
            builder.setLogBtnHeight((Integer) setLogBtnHeight);
        }
        if (null != setLogBtnWidth) {
            builder.setLogBtnWidth((Integer) setLogBtnWidth);
        }
        if (null != setLogBtnOffsetX) {
            builder.setLogBtnOffsetX((Integer) setLogBtnOffsetX);
        }
        //授权页 隐私协议栏
        if (null != setAppPrivacyOne) {
            ArrayList<String> setAppPrivacyOneList = (ArrayList) setAppPrivacyOne;
            setAppPrivacyOneList.addAll(Arrays.asList("", ""));
            builder.setAppPrivacyOne(setAppPrivacyOneList.get(0), setAppPrivacyOneList.get(1));
        }
        if (null != setAppPrivacyTwo) {
            ArrayList<String> setAppPrivacyTwoList = (ArrayList) setAppPrivacyTwo;
            setAppPrivacyTwoList.addAll(Arrays.asList("", ""));
            builder.setAppPrivacyTwo(setAppPrivacyTwoList.get(0), setAppPrivacyTwoList.get(1));
        }
        if (null != setAppPrivacyThree) {
            ArrayList<String> setAppPrivacyThreeList = (ArrayList) setAppPrivacyThree;
            setAppPrivacyThreeList.addAll(Arrays.asList("", ""));
            builder.setAppPrivacyThree(setAppPrivacyThreeList.get(0), setAppPrivacyThreeList.get(1));
        }
        if (null != setPrivacySmhHidden) {
            builder.setPrivacySmhHidden((Boolean) setPrivacySmhHidden);
        }
        if (null != setPrivacyTextSize) {
            builder.setPrivacyTextSize((Integer) setPrivacyTextSize);
        }
        if (null != setAppPrivacyColor) {
            ArrayList<String> setAppPrivacyColorList = (ArrayList) setAppPrivacyColor;
            setAppPrivacyColorList.addAll(Arrays.asList("", ""));
            builder.setAppPrivacyColor(Color.parseColor(setAppPrivacyColorList.get(0)), Color.parseColor(setAppPrivacyColorList.get(1)));
        }
        if (null != setPrivacyOffsetBottomY) {
            builder.setPrivacyOffsetBottomY((Integer) setPrivacyOffsetBottomY);
        }
        if (null != setPrivacyOffsetY) {
            builder.setPrivacyOffsetY((Integer) setPrivacyOffsetY);
        }
        if (null != setPrivacyOffsetX) {
            builder.setPrivacyOffsetX((Integer) setPrivacyOffsetX);
        }
        if (null != setPrivacyOffsetGravityLeft) {
            builder.setPrivacyOffsetGravityLeft((Boolean) setPrivacyOffsetGravityLeft);
        }
        if (null != setPrivacyState) {
            builder.setPrivacyState((Boolean) setPrivacyState);
        }
        if (null != setUncheckedImgPath) {
            builder.setUncheckedImgPath(getDrawableByReflect(setUncheckedImgPath));
        }
        if (null != setCheckedImgPath) {
            builder.setCheckedImgPath(getDrawableByReflect(setCheckedImgPath));
        }
        if (null != setCheckBoxHidden) {
            builder.setCheckBoxHidden((Boolean) setCheckBoxHidden);
        }
        if (null != setCheckBoxWH) {
            ArrayList<Integer> setCheckBoxWHList = (ArrayList) setCheckBoxWH;
            setCheckBoxWHList.addAll(Arrays.asList(0, 0));
            builder.setCheckBoxWH(setCheckBoxWHList.get(0), setCheckBoxWHList.get(1));
        }
        if (null != setCheckBoxMargin) {
            ArrayList<Integer> setCheckBoxMarginList = (ArrayList) setCheckBoxMargin;
            setCheckBoxMarginList.addAll(Arrays.asList(0, 0, 0, 0));
            builder.setCheckBoxMargin(setCheckBoxMarginList.get(0), setCheckBoxMarginList.get(1), setCheckBoxMarginList.get(2), setCheckBoxMarginList.get(3));
        }
        if (null != setPrivacyText) {
            ArrayList<String> setPrivacyTextList = (ArrayList) setPrivacyText;
            setPrivacyTextList.addAll(Arrays.asList("", "", "", "", ""));
            builder.setPrivacyText(setPrivacyTextList.get(0), setPrivacyTextList.get(1), setPrivacyTextList.get(2), setPrivacyTextList.get(3), setPrivacyTextList.get(4));
        }
        //授权页 slogan（***提供认证服务）
        if (null != setSloganTextColor) {
            builder.setSloganTextColor(Color.parseColor((String) setSloganTextColor));
        }
        if (null != setSloganTextSize) {
            builder.setSloganTextSize((Integer) setSloganTextSize);
        }
        if (null != setSloganOffsetY) {
            builder.setSloganOffsetY((Integer) setSloganOffsetY);
        }
        if (null != setSloganHidden) {
            builder.setSloganHidden((Boolean) setSloganHidden);
        }
        if (null != setSloganOffsetBottomY) {
            builder.setSloganOffsetBottomY((Integer) setSloganOffsetBottomY);
        }
        if (null != setSloganOffsetX) {
            builder.setSloganOffsetX((Integer) setSloganOffsetX);
        }
        if (null != setDialogTheme) {
            ArrayList<String> setDialogThemeList = (ArrayList) setDialogTheme;
            setDialogThemeList.addAll(Arrays.asList("0", "0", "0", "0", "false"));
            builder.setDialogTheme(true, dp2Pix(context, Integer.parseInt(setDialogThemeList.get(0))),
                    dp2Pix(context, Integer.parseInt(setDialogThemeList.get(1))), dp2Pix(context, Integer.parseInt(setDialogThemeList.get(2))),
                    dp2Pix(context, Integer.parseInt(setDialogThemeList.get(3))), Boolean.parseBoolean(setDialogThemeList.get(4)));
        }

    }

    private Object valueForKey(Map para, String key) {
        if (para != null && para.containsKey(key)) {
            return para.get(key);
        } else {
            return null;
        }
    }

    public int getLayoutForId(String layoutname) {
        if (null == layoutname) {
            return 0;
        } else {
            Resources mResources = context.getResources();
            if (mResources != null) {
                return mResources.getIdentifier(layoutname, "layout", context.getPackageName());
            } else {
                return 0;
            }
        }
    }

    /*
     * 取id资源
     */
    public int getId(String idname) {
        if (null == idname) {
            return 0;
        } else {
            Resources mResources = context.getResources();
            if (mResources != null) {
                return mResources.getIdentifier(idname, "id", context.getPackageName());
            } else {
                return 0;
            }
        }
    }

    private Drawable getDrawableByReflect(Object imageName) {
        Class drawable = R.drawable.class;
        Field field = null;
        int r_id = 0;
        if (null == imageName) {
            return null;
        }
        try {
            field = drawable.getField((String) imageName);
            r_id = field.getInt(field.getName());
        } catch (Exception e) {
            r_id = 0;
        }
        if (r_id == 0) {
            r_id = context.getResources().getIdentifier((String) imageName, "drawable", context.getPackageName());
        }
        if (r_id == 0) {
            r_id = context.getResources().getIdentifier((String) imageName, "mipmap", context.getPackageName());
        }
        return context.getResources().getDrawable(r_id);
    }

    /**
     * 获取对齐方式
     */
    private int getAlignmentFromString(String alignmet) {
        int a = 0;
        if (alignmet != null) {
            switch (alignmet) {
                case "left":
                    a = Gravity.LEFT;
                    break;
                case "top":
                    a = Gravity.TOP;
                    break;
                case "right":
                    a = Gravity.RIGHT;
                    break;
                case "bottom":
                    a = Gravity.BOTTOM;
                    break;
                case "center":
                    a = Gravity.CENTER;
                    break;
                default:
                    a = Gravity.NO_GRAVITY;
                    break;
            }
        }
        return a;
    }

    private int dp2Pix(Context context, float dp) {
        try {
            float density = context.getResources().getDisplayMetrics().density;
            return (int) (dp * density + 0.5F);
        } catch (Exception e) {
            return (int) dp;
        }
    }
}
