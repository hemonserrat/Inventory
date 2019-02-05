package exampleflutter.mfs.com.flutter3listview;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Currency;
import java.util.List;
import java.util.UUID;


import co.poynt.api.model.CurrencyAmount;
import co.poynt.api.model.Order;
import co.poynt.api.model.OrderAmounts;
import co.poynt.api.model.OrderItem;
import co.poynt.api.model.OrderItemStatus;
import co.poynt.api.model.OrderStatus;
import co.poynt.api.model.OrderStatuses;
import co.poynt.api.model.Product;
import co.poynt.api.model.ProductType;
import co.poynt.api.model.SelectableValue;
import co.poynt.api.model.SelectableVariation;
import co.poynt.api.model.UnitOfMeasure;
import co.poynt.api.model.Variant;


public class Util {

    public static Order generateOrder(String itemName, long itemprice, float quantity) {
        Order order = new Order();
        order.setId(UUID.randomUUID());
        List<OrderItem> items = new ArrayList<OrderItem>();
        // create some dummy items to display in second screen
        items = new ArrayList<OrderItem>();
        OrderItem item1 = new OrderItem();
        // these are the only required fields for second screen display
        item1.setName(itemName);
        item1.setUnitPrice(itemprice);
        item1.setQuantity(quantity);
        item1.setUnitOfMeasure(UnitOfMeasure.EACH);
        item1.setStatus(OrderItemStatus.FULFILLED);
        item1.setTax(0l);
        items.add(item1);

        BigDecimal subTotal = new BigDecimal(0);
        for (OrderItem item : items) {
            BigDecimal price = new BigDecimal(item.getUnitPrice());
            price.setScale(2, RoundingMode.HALF_UP);
            price = price.multiply(new BigDecimal(item.getQuantity()));
            subTotal = subTotal.add(price);
        }

        OrderAmounts amounts = new OrderAmounts();
        amounts.setCurrency("USD");
        amounts.setSubTotal(subTotal.longValue());

        // for simplicity assuming netTotal is the same as subTotal
        // normally: netTotal = subTotal + taxTotal - discountTotal + cashback
        amounts.setNetTotal(subTotal.longValue());
        order.setAmounts(amounts);

        OrderStatuses orderStatuses = new OrderStatuses();
        orderStatuses.setStatus(OrderStatus.COMPLETED);
        order.setStatuses(orderStatuses);
        order.setId(UUID.randomUUID());
        return order;
    }

}
