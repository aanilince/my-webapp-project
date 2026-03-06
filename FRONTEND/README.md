# Frontend Files

Bu klasör uygulamanın frontend (UI) dosyalarını içerir.

## Dosyalar

### 📄 index.jsp
Uygulamanın ana arayüzü. Tarayıcıda görünen sayfa.
- **Konumu:** `src/main/webapp/index.jsp`

### 🎨 css/style.css
Tüm stil ve tasarım dosyası. Renk, düzen, tipografi vb.
- **Konumu:** `src/main/webapp/css/style.css`

### 🔧 js/app.js
JavaScript kodu. Backend API'si ile iletişim kurar.
- **Konumu:** `src/main/webapp/js/app.js`

## Özellikler

- ✅ Not oluşturma formu
- ✅ Not listesi gösterimi
- ✅ Not silme işlevi
- ✅ Backend API ile senkronizasyon
- ✅ Dark theme UI

## Nasıl Çalışır?

1. Kullanıcı formu doldurur (Yazar adı + Not içeriği)
2. JavaScript `app.js` backend API'sine POST isteği gönderir
3. Backend not kaydeder, yanıt döner
4. Frontend otomatik olarak listeyi günceller
