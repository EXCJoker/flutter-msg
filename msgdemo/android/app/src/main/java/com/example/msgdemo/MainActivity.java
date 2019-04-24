package com.example.msgdemo;

import android.content.Intent;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  public static final String CHANNEL = "com.example/msgdemo";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(),CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, MethodChannel.Result result) {
          receiveMsg(call,result,MainActivity.this);
      }
    });
  }

  private void receiveMsg(MethodCall call, MethodChannel.Result result, MainActivity activity) {
    //通过MethodCall可以获取参数和方法名，然后再寻找对应的平台业务，本案例做了2个跳转的业务

    //接收来自flutter的指令oneAct
    if (call.method.equals("oneAct")) {

      //跳转到指定Activity
      Intent intent = new Intent(activity, FirstActivity.class);
      activity.startActivity(intent);

      //返回给flutter的参数
      result.success("success");
    }
    //接收来自flutter的指令twoAct
    else if (call.method.equals("twoAct")) {

      //解析参数
      String text = call.argument("flutter");

      //带参数跳转到指定Activity
      Intent intent = new Intent(activity, SecondActivity.class);
      intent.putExtra(SecondActivity.VALUE, text);
      activity.startActivity(intent);

      //返回给flutter的参数
      result.success("success");
    }
    else {
      result.notImplemented();
    }
  }
}
