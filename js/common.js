

/* LOVE NOTE GLOBAL CORE */

const LoveNoteConfig = {
  PAID_KEY: "lovenote_paid",
  USER_KEY: "lovenote_user",
};

/* ---------------- PAYMENT STATE ---------------- */

export function setPaidTrue() {
  localStorage.setItem(LoveNoteConfig.PAID_KEY, "true");
}

export function isPaidUser() {
  return localStorage.getItem(LoveNoteConfig.PAID_KEY) === "true";
}

/* ---------------- SESSION ---------------- */

export function saveUserSession(user) {
  localStorage.setItem(LoveNoteConfig.USER_KEY, JSON.stringify(user));
}

export function getUserSession() {
  return JSON.parse(localStorage.getItem(LoveNoteConfig.USER_KEY));
}

export function logoutUser() {
  localStorage.removeItem(LoveNoteConfig.USER_KEY);
  window.location.href = "/login.html";
}

/* ---------------- GUARDS ---------------- */

export function requireLogin() {
  if (!getUserSession()) window.location.href = "/login.html";
}

export function requirePayment() {
  if (!isPaidUser()) {
    document.body.classList.add("payment-locked");
  }
}
