import {onCall} from "firebase-functions/v2/https";
import {getStorage} from "firebase-admin/storage";
import {getFirestore} from "firebase-admin/firestore";
import * as admin from "firebase-admin/app";
import {promises as fs} from "fs";
admin.initializeApp();

const firestore = getFirestore();
const storage = getStorage();

export const processMenuItems = onCall(async (request) => {
  const data = request.data;

  // Validate input parameters
  if (!data || !data.fileName) {
    throw new Error("File name is required.");
  }
  if (!data.restaurantId) {
    throw new Error("Restaurant ID is required.");
  }

  const fileName = data.fileName;
  const restaurantId = data.restaurantId;


  const filePath = `Restaurant Menu Files/${fileName}`;
  const tempFilePath = `/tmp/${fileName}`;

  try {
    // Download the file from Cloud Storage
    const bucket = storage.bucket();
    const file = bucket.file(filePath);
    await file.download({destination: tempFilePath});

    console.log("File downloaded successfully:", tempFilePath);

    const fileContent = await fs.readFile(tempFilePath, "utf-8");
    const jsonData = JSON.parse(fileContent);

    if (!Array.isArray(jsonData)) {
      throw new Error("The file must contain an array of menu items.");
    }

    const batch = firestore.batch();
    const menuCollection= firestore.collection("restaurantMenu");

    jsonData.forEach((menuItem) => {
      const menuRef =menuCollection.doc();
      menuItem.id = menuRef.id; // Assign document ID to the id field
      menuItem.resId=restaurantId;
      batch.set(menuRef, menuItem);
    });

    await batch.commit();
    console.log("Menu items processed and uploaded successfully.");
    // Delete the file from Cloud Storage after processing
    await file.delete();
    console.log("File deleted successfully from Cloud Storage:", filePath);

    // Delete the temporary file after processing
    await fs.unlink(tempFilePath);
    console.log("Temporary file deleted successfully:", tempFilePath);
    return {success: true, message: "Menu items processed and uploaded successfully."};
  } catch (error) {
    console.error("Error processing menu items:", error);
    throw new Error("Failed to process menu items. " + error.message);
  }
});
