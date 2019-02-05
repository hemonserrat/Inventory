package exampleflutter.mfs.com.flutter3listview;

import android.app.Activity;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.view.ViewTreeObserver;
import android.view.WindowManager;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import co.poynt.api.model.Card;
import co.poynt.api.model.CardType;
import co.poynt.api.model.FundingSourceAccountType;
import co.poynt.api.model.Order;
import co.poynt.api.model.Transaction;
import co.poynt.api.model.TransactionAction;
import co.poynt.api.model.TransactionAmounts;
import co.poynt.api.model.TransactionReference;
import co.poynt.api.model.TransactionReferenceType;
import co.poynt.os.contentproviders.orders.transactionreferences.TransactionreferencesColumns;
import co.poynt.os.model.Intents;
import co.poynt.os.model.Payment;
import co.poynt.os.model.PaymentStatus;
import co.poynt.os.model.PoyntError;

public class CheckoutActivity extends Activity {

    private static final String TAG = "CheckoutActivity";


    private static final int COLLECT_PAYMENT_WITH_TIP_REQUEST = 13131;
    private static final int COLLECT_PAYMENT_REQUEST = 13132;

    Button payOrderBtn;
    TextView itemName;
    TextView itemQuantity;
    TextView itemPrice;

    String lastReferenceId;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.layout);

        Bundle bundle = getIntent().getExtras();

        String item = bundle.getString("item");
        String cost = bundle.getString("cost");
        String stock = "1"; //bundle.getString("stock");
        String category = bundle.getString("category");

        Log.d(TAG, "item " + item);
        Log.d(TAG, "cost " + cost);
        Log.d(TAG, "stock " + stock);

        itemName = (TextView) findViewById(R.id.item_name);
        itemName.setText(item);

        itemQuantity = (TextView) findViewById(R.id.item_quantity);
        itemQuantity.setText(stock);

        itemPrice = (TextView) findViewById(R.id.sale_amount);

        final Order order = Util.generateOrder(item,
                Long.parseLong(cost), // ToDo Change cost to long
                Long.parseLong(stock));
        itemPrice.setText(Long.toString(order.getAmounts().getNetTotal()));

        payOrderBtn = (Button) findViewById(R.id.payOrderBtn);
        payOrderBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                long payableAmount = order.getAmounts().getNetTotal() * 100;
                launchPoyntPayment(payableAmount, true, order);
            }
        });
    }

    private void launchPoyntPayment(long amount, boolean collectTip, Order order) {
        String currencyCode = NumberFormat.getCurrencyInstance().getCurrency().getCurrencyCode();

        Payment payment = new Payment();
        lastReferenceId = UUID.randomUUID().toString();
        payment.setReferenceId(lastReferenceId);

        payment.setCurrency(currencyCode);
        // enable multi-tender in payment options
        payment.setMultiTender(true);

        if (order != null) {
            payment.setOrder(order);
            payment.setOrderId(order.getId().toString());

            // tip can be preset
            //payment.setTipAmount(500l);
            payment.setAmount(amount);
        } else {
            // some random amount
            payment.setAmount(1200l);

            // here's how tip can be disabled for tip enabled merchants
            // payment.setDisableTip(true);
        }

        payment.setSkipSignatureScreen(true);
        payment.setSkipReceiptScreen(true);
        payment.setSkipPaymentConfirmationScreen(true);

        payment.setCallerPackageName("co.poynt.sample");
        Map<String, String> processorOptions = new HashMap<>();
        processorOptions.put("installments", "2");
        processorOptions.put("type", "emi");
        processorOptions.put("originalAmount", "2400");
        payment.setProcessorOptions(processorOptions);

        // start Payment activity for result
        try {
            Intent collectPaymentIntent = new Intent(Intents.ACTION_COLLECT_PAYMENT);
            collectPaymentIntent.putExtra(Intents.INTENT_EXTRAS_PAYMENT, payment);
            if (collectTip) {
                startActivityForResult(collectPaymentIntent, COLLECT_PAYMENT_WITH_TIP_REQUEST);
            } else {
                startActivityForResult(collectPaymentIntent, COLLECT_PAYMENT_REQUEST);
            }
        } catch (ActivityNotFoundException ex) {
            Log.e(TAG, "Poynt Payment Activity not found - did you install PoyntServices?", ex);
        }

    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        Log.d(TAG, "Received onActivityResult (" + requestCode + ")");

        if (requestCode == COLLECT_PAYMENT_REQUEST) {
            setResult(Activity.RESULT_OK);
        } else if (requestCode == COLLECT_PAYMENT_WITH_TIP_REQUEST) {
            setResult(Activity.RESULT_OK);
        }
        finish();
    }

}
