import {onCall} from "firebase-functions/v2/https";
import {getFirestore} from "firebase-admin/firestore";
import * as admin from "firebase-admin/app";

admin.initializeApp();
const firestore = getFirestore();
export const processMenuItems = onCall(async (request) => {
  const data = request.data;
  // Validate input parameters
  if (!data || !data.restaurantId) {
    throw new Error("Restaurant ID is required.");
  }
  if (!data.menuJson) {
    throw new Error("Menu JSON data is required.");
  }
  try {
    const jsonData = JSON.parse(data.menuJson);

    if (!Array.isArray(jsonData)) {
      throw new Error("Invalid JSON format. Expected an array of menu items.");
    }
    const batch = firestore.batch();
    const menuCollection= firestore.collection("restaurantMenu");

    jsonData.forEach((menuItem) => {
      const menuRef =menuCollection.doc();
      menuItem.id = menuRef.id; // Assign document ID to the id field
      menuItem.resId=data.restaurantId;
      batch.set(menuRef, menuItem);
    });

    await batch.commit();
    console.log("Menu items processed and uploaded successfully.");
    return {success: true, message: "Menu items processed and uploaded successfully."};
  } catch (error) {
    console.error("Error processing menu items:", error);
    throw new Error("Failed to process menu items. " + error.message);
  }
});
