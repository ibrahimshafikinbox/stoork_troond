# Troond Chat System - Backend Specification (API & Database)

> **Platform:** Troond E-Commerce App  
> **Target Audience:** Backend Developers & DevOps  
> **Language:** English  
> **Status:** Ready for Implementation  

---

## 1. Overview & Flow

The Troond Chat system enables real-time 1-on-1 communication between a **Customer** (Mobile User) and a **Seller/Merchant**.

### Supported Message Types
1. **Text**: Standard text messages.
2. **Product Inquiry**: Message linked to a specific product context (title, price, image).
3. **Image**: Photos sent from Camera or Gallery.
4. **Voice Note**: Audio recordings (.m4a/.aac/.mp3) with duration and waveform visualization.

### Message Status Lifecycle
`sending` ➔ `sent` ➔ `delivered` ➔ `read`

---

## 2. Database Schema

### Table: `chats`
Stores 1-on-1 conversation sessions between a customer and a seller.

```sql
CREATE TABLE `chats` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` BIGINT UNSIGNED NOT NULL,
  `seller_id` BIGINT UNSIGNED NOT NULL,
  `product_id` BIGINT UNSIGNED NULL DEFAULT NULL COMMENT 'Initial product context if chat started from product page',
  `last_message_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `last_message_at` TIMESTAMP NULL DEFAULT NULL,
  `unread_customer_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `unread_seller_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `status` ENUM('active', 'archived', 'blocked') NOT NULL DEFAULT 'active',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_chat` (`customer_id`, `seller_id`),
  INDEX `idx_customer_inbox` (`customer_id`, `last_message_at` DESC),
  INDEX `idx_seller_inbox` (`seller_id`, `last_message_at` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

---

### Table: `chat_messages`
Stores all chat messages.

```sql
CREATE TABLE `chat_messages` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `chat_id` BIGINT UNSIGNED NOT NULL,
  `sender_id` BIGINT UNSIGNED NOT NULL,
  `sender_type` ENUM('customer', 'seller') NOT NULL DEFAULT 'customer',
  `type` ENUM('text', 'image', 'voice', 'product') NOT NULL DEFAULT 'text',
  `content` TEXT NULL DEFAULT NULL,
  `product_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `file_url` VARCHAR(2048) NULL DEFAULT NULL COMMENT 'Public URL for images and voice notes',
  `voice_duration` INT UNSIGNED NULL DEFAULT NULL COMMENT 'Audio duration in seconds',
  `waveform` JSON NULL DEFAULT NULL COMMENT 'Array of normalized amplitudes (0.0 - 1.0) for audio wave',
  `status` ENUM('sending', 'sent', 'delivered', 'read') NOT NULL DEFAULT 'sent',
  `read_at` TIMESTAMP NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_chat_history` (`chat_id`, `created_at` DESC, `id` DESC),
  CONSTRAINT `fk_messages_chat` FOREIGN KEY (`chat_id`) REFERENCES `chats` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

---

## 3. RESTful API Endpoints

**Base URL:** `https://api.troond.com/api/`  
**Authentication:** Standard Bearer Token in Header  
```http
Authorization: Bearer <USER_TOKEN>
Accept: application/json
Content-Type: application/json
```

---

### Endpoint 1: Initialize or Get Existing Chat
- **Route:** `POST /api/customer/chats`
- **Description:** Returns the existing conversation between the logged-in customer and the seller, or creates one if it doesn't exist.
- **Request Body:**
```json
{
  "seller_id": 14,
  "product_id": 1025
}
```
- **Success Response (`200 OK` or `201 Created`):**
```json
{
  "status": true,
  "message": "Chat retrieved successfully",
  "data": {
    "id": 85,
    "seller_id": 14,
    "seller": {
      "id": 14,
      "name": "Smart Tech Store",
      "logo": "https://api.troond.com/storage/sellers/14.png",
      "rating": 4.8,
      "rating_count": 28,
      "is_verified": true,
      "is_online": true
    },
    "product": {
      "id": 1025,
      "title": "Wireless Pro Headphones",
      "price": "249.00 SAR",
      "image": "https://api.troond.com/storage/products/1025.jpg"
    },
    "unread_count": 0,
    "created_at": "2026-10-26T10:00:00Z"
  }
}
```

---

### Endpoint 2: Get Chat Messages
- **Route:** `GET /api/customer/chats/{chat_id}/messages`
- **Description:** Fetches the list of messages for a chat session.
- **Success Response (`200 OK`):**
```json
{
  "status": true,
  "data": [
    {
      "id": 401,
      "chat_id": 85,
      "sender_id": 501,
      "is_me": true,
      "type": "text",
      "content": "Hello, is this product available in black?",
      "media_url": null,
      "voice_duration": null,
      "status": "read",
      "created_at": "2026-10-26T10:05:00Z"
    },
    {
      "id": 402,
      "chat_id": 85,
      "sender_id": 14,
      "is_me": false,
      "type": "text",
      "content": "Hello! Yes, it is in stock and ready for immediate shipping.",
      "media_url": null,
      "voice_duration": null,
      "status": "read",
      "created_at": "2026-10-26T10:06:00Z"
    }
  ]
}
```

---

### Endpoint 3: Send Text Message
- **Route:** `POST /api/customer/chats/{chat_id}/messages`
- **Description:** Sends a plain text message or a product inquiry.
- **Request Body:**
```json
{
  "content": "Can you provide a discount for 2 items?",
  "type": "text",
  "product_id": 1025
}
```
- **Success Response (`201 Created`):**
```json
{
  "status": true,
  "data": {
    "id": 403,
    "chat_id": 85,
    "sender_id": 501,
    "type": "text",
    "content": "Can you provide a discount for 2 items?",
    "product_id": 1025,
    "status": "sent",
    "created_at": "2026-10-26T10:10:00Z"
  }
}
```

---

### Endpoint 4: Upload & Send Image
- **Route:** `POST /api/customer/chats/{chat_id}/files`
- **Header:** `Content-Type: multipart/form-data`
- **Form Fields:**
  - `file`: *(Binary file: jpg, png, webp)*
  - `type`: `"image"`
  - `caption`: *(Optional text)*
- **Success Response (`201 Created`):**
```json
{
  "status": true,
  "data": {
    "id": 404,
    "chat_id": 85,
    "sender_id": 501,
    "type": "image",
    "file_url": "https://api.troond.com/storage/chats/img_404.jpg",
    "content": "Is this the exact model?",
    "status": "sent",
    "created_at": "2026-10-26T10:15:00Z"
  }
}
```

---

### Endpoint 5: Upload & Send Voice Note
- **Route:** `POST /api/customer/chats/{chat_id}/voice`
- **Header:** `Content-Type: multipart/form-data`
- **Form Fields:**
  - `voice`: *(Binary audio file: m4a, aac, mp3)*
  - `duration`: `14` *(Integer in seconds)*
  - `type`: `"voice"`
- **Success Response (`201 Created`):**
```json
{
  "status": true,
  "data": {
    "id": 405,
    "chat_id": 85,
    "sender_id": 501,
    "type": "voice",
    "file_url": "https://api.troond.com/storage/chats/voice_405.m4a",
    "voice_duration": 14,
    "waveform": [0.2, 0.4, 0.8, 0.6, 0.9, 0.3, 0.7, 0.5],
    "status": "sent",
    "created_at": "2026-10-26T10:18:00Z"
  }
}
```

---

### Endpoint 6: Mark Messages as Read
- **Route:** `PATCH /api/customer/chats/{chat_id}/read`
- **Description:** Marks all incoming unread messages as read and resets unread badge count.
- **Success Response (`200 OK`):**
```json
{
  "status": true,
  "message": "Messages marked as read",
  "unread_count": 0
}
```

---

## 4. Real-Time WebSockets (Pusher / Socket.io / Reverb)

To provide an instant WhatsApp-like experience without polling:

### Private Channel
`private-chat.{chat_id}`

### Events to Broadcast

| Event Name | Trigger | Broadcast Payload |
| :--- | :--- | :--- |
| `message.sent` | When any party sends a message | Complete message object (`id`, `content`, `type`, `file_url`, etc.) |
| `message.read` | When recipient opens the chat | `{"chat_id": 85, "read_by": 14, "read_at": "2026-10-26T10:20:00Z"}` |
| `user.typing` | When user is typing in input box | `{"chat_id": 85, "user_id": 501, "is_typing": true}` |
| `user.presence`| When user goes online / offline | `{"user_id": 14, "status": "online"}` |

---

## 5. Push Notifications (Firebase FCM)

When the recipient is **not connected** to the WebSocket (app in background or closed):

### FCM HTTP v1 Payload Example:
```json
{
  "message": {
    "token": "<FCM_DEVICE_TOKEN>",
    "notification": {
      "title": "Smart Tech Store",
      "body": "Yes, it is in stock and ready for immediate shipping."
    },
    "data": {
      "type": "chat_message",
      "chat_id": "85",
      "seller_id": "14",
      "sender_name": "Smart Tech Store",
      "click_action": "FLUTTER_NOTIFICATION_CLICK"
    },
    "android": {
      "priority": "high",
      "notification": {
        "channel_id": "troond_chat_channel",
        "sound": "default"
      }
    },
    "apns": {
      "payload": {
        "aps": {
          "sound": "default",
          "badge": 1
        }
      }
    }
  }
}
```

---

## 6. Key Model Compatibility for Flutter Mobile App

The Flutter app expects the following property mappings in `ChatMessageModel.fromJson`:
- `id`: Unique identifier (string or int).
- `chat_id`: Int.
- `sender_id` or `user_id`: Sender's ID.
- `is_me`: Boolean (calculated or sent by backend).
- `type` or `file_type`: `'text'`, `'image'`, `'voice'`, or `'product'`.
- `content` or `message`: Text content.
- `media_url` or `file_url`: URL for image/voice file.
- `voice_duration` or `duration`: Duration in seconds.
- `status`: `'sending'`, `'sent'`, `'delivered'`, `'read'`.
