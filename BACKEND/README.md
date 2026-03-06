# Backend Files

Bu klasör uygulamanın backend (sunucu) kodlarını içerir.

## Dosyalar

### 🔨 servlet/NoteServlet.java
REST API servlet'i. Frontend'in isteklerini işler.
- **Konumu:** `src/main/java/com/example/servlet/NoteServlet.java`

## API Endpoints

### GET `/api/notes`
Tüm notları getirir.

**Yanıt:**
```json
[
  {
    "id": 1,
    "author": "Ahmet",
    "content": "İlk notum",
    "timestamp": "2026-03-06T10:30:00"
  }
]
```

### POST `/api/notes`
Yeni bir not ekler.

**İstek:**
```json
{
  "author": "Ahmet",
  "content": "Yeni not"
}
```

**Yanıt:**
```json
{
  "id": 2,
  "author": "Ahmet",
  "content": "Yeni not",
  "timestamp": "2026-03-06T10:35:00"
}
```

### DELETE `/api/notes/{id}`
Verilen ID'li notu siler.

**Yanıt:**
```json
{
  "success": true
}
```

## Teknolojiler

- **Java Servlet** - Web istek işlemesi
- **Gson** - JSON dönüşümleri
- **Jetty** - Sunucu

## Veri Saklama

Şu an in-memory storage kullanıyor (uygulama yeniden başlatılınca verileri kaybolur).
Production için veritabanına bağlanması gerekir.
