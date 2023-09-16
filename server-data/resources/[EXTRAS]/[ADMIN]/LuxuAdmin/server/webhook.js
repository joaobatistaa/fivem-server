const axios = require("axios");
const defaultWebhook = GetConvar("DiscordWebhook");
const ResourceName = GetCurrentResourceName();

// Rate limiter configuration
const maxRequests = 2;
const timeWindow = 1000; // 1 seconds
let requestCounter = 0;
let lastResetTimestamp = Date.now();

async function sendWebhook({ webhook = defaultWebhook, message }) {
  if (!message) return;

  // Rate limiter logic
  const currentTime = Date.now();
  if (currentTime - lastResetTimestamp > timeWindow) {
    requestCounter = 0;
    lastResetTimestamp = currentTime;
  }

  if (requestCounter >= maxRequests) {
    /*   console.error("Too many webhook requests, ignoring this message."); */
    return;
  }

  requestCounter++;

  const content = "**LuxuAdmin 👁️**" + "\n" + message;

  // Send post request
  try {
    const result = await axios.post(webhook, {
      username: "Luxu",
      content,
      avatar_url: "",
    });
  } catch (e) {
    console.error(e);
  }
}

exports("sendWebhook", sendWebhook);
