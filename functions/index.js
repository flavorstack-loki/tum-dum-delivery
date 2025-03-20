import {onRequest} from "firebase-functions/v2/https";
import logger from "firebase-functions/logger";
import admin from "firebase-admin";
import {initializeApp} from "firebase-admin/app";
import express from "express";
import axios from "axios";

// Load environment variables in local development


initializeApp();
const app = express();
app.use(express.json());


// OTP Verification Endpoint
app.post("/verify-otp", async (req, res) => {
  // Securely access MSG91 Auth Key
  const MSG91_OTP_AUTH_KEY = process.env.MSG91_OTP_AUTH_KEY;

  if (!MSG91_OTP_AUTH_KEY) {
    logger.error("Missing MSG91_OTP_AUTH_KEY. Set it using 'firebase functions:env:set'.");
    throw new Error("MSG91_OTP_AUTH_KEY is required.");
  }
  const {phone, otp} = req.body;

  if (!phone || !otp) {
    return res.status(400).json({error: "Phone number and OTP are required."});
  }

  try {
    const otpResponse = await axios.post("https://api.msg91.com/api/v5/otp/verify", {
      authkey: MSG91_OTP_AUTH_KEY,
      mobile: phone,
      otp: otp,
    });

    if (otpResponse.data.type !== "success") {
      console.log(otpResponse.data);
      return res.status(400).json({error: otpResponse.data.message});
    }

    const uid = `custom:${phone}`;
    const firebaseToken = await admin.auth().createCustomToken(uid);

    res.json({token: firebaseToken});
  } catch (error) {
    logger.error("OTP Verification Failed:", error);
    res.status(500).json({error: "OTP verification failed"});
  }
});

// Export the function using Gen 2 format
export const api = onRequest({region: "us-central1"}, app);
