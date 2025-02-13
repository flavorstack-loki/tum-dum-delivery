import * as functions from "firebase-functions";
import * as admin from "firebase-admin/app";
import {getFirestore} from "firebase-admin/firestore";
import {getMessaging} from "firebase-admin/messaging";
admin.initializeApp();
const db = getFirestore();

export const onNewOrderCreated = functions.firestore.onDocumentCreated("customerOrders/{orderId}", async (event) => {
  const snapshot = event.data;
  if (!snapshot) {
    console.log("No data in snapshot");
    return;
  }

  const orderData = snapshot.data();
  if (!orderData || !orderData.res_id) {
    console.log("Missing restaurantId in order data");
    return;
  }

  try {
    // Find the restaurant document based on restaurantId
    const restaurantQuery = await db
        .collection("signedUpRestaurant")
        .where("resturantId", "==", orderData.res_id)
        .limit(1)
        .get();

    if (restaurantQuery.empty) {
      console.log("No matching restaurant found for restaurantId:", orderData.res_id);
      return;
    }

    const restaurantDoc = restaurantQuery.docs[0];
    const restaurantData = restaurantDoc.data();
    const deviceToken = restaurantData.deviceToken;

    if (!deviceToken) {
      console.log("No device token found for restaurantId:", orderData.resturantId);
      return;
    }

    // Prepare the notification payload
    const payload = {
      notification: {
        title: "You have received an order 🔔",
        body: "Please open the app to view the order details",
      },
      token: deviceToken,
      android: {
        notification: {
          channel_id: "high_importance_channel",
        },
      },
      data: {
        click_action: "FLUTTER_NOTIFICATION_CLICK",
      },
    };

    // Send notification
    await getMessaging().send(payload);
    console.log(restaurantData.resturantId);
    console.log("Notification sent successfully to:", restaurantData.userName);
  } catch (error) {
    console.error("Error sending notification:", error);
  }
});

