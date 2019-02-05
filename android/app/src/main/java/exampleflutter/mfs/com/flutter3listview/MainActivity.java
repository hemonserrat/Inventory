package exampleflutter.mfs.com.flutter3listview;

import android.view.ViewTreeObserver;
import android.view.WindowManager;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.util.Log;
import java.util.Map;

public class MainActivity extends FlutterActivity {

    private static final String TAG = "MainActivity";

    private static final String CHANNEL = "exampleflutter.mfs.com.flutter3listview";

    private static final int PAYMENT_RESPONSE = 1423;

    private Map<String, Object> arguments;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //make transparent status bar
        getWindow().setStatusBarColor(0x00000000);
        GeneratedPluginRegistrant.registerWith(this);

        initFlutterChannel();

        //Remove full screen flag after load
        ViewTreeObserver vto = getFlutterView().getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                getFlutterView().getViewTreeObserver().removeOnGlobalLayoutListener(this);
                getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
            }
        });
    }

    /**
     * Initialize MethodChannel and add cases of every methods that will be sent from Flutter
     */
    private void initFlutterChannel() {

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        if (call.method.equals("openPage")) {

                            arguments = (Map<String, Object>) call.arguments;

                            openSecondActivity(arguments);
                        }
                        result.success(1);
                    }
                });
    }

    private void openSecondActivity(Map<String, Object> arguments) {

        Log.d(TAG, "openSecondActivity " + arguments);

        Bundle bundle = new Bundle();
        bundle.putString("item", (String) arguments.get("item")); // name
        bundle.putString("cost", (String) arguments.get("cost")); // price
        //bundle.putString("stock", (String) arguments.get("stock")); // quantity
        bundle.putString("stock", "1"); // quantity
        bundle.putString("category", (String) arguments.get("category"));

        Intent intent = new Intent(this, CheckoutActivity.class);
        intent.putExtras(bundle);
        startActivityForResult(intent, PAYMENT_RESPONSE);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        Log.d(TAG, "Received onActivityResult (" + requestCode + ")");
    }

}
