<p align="center">
  <img src="app/dashboard/build/statics/logo.png" alt="TM BEGO Logo" width="120" />
</p>

<h1 align="center">🇹🇲 TM BEGO — Professional VPN Dolandyryş Paneli</h1>

<p align="center">
  <b>Xray-core esasly, döwrebap VPN dolandyryş platformasy</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20Docker-blue?style=for-the-badge&logo=docker" />
  <img src="https://img.shields.io/badge/Backend-FastAPI-green?style=for-the-badge&logo=fastapi" />
  <img src="https://img.shields.io/badge/Frontend-React%20%7C%20Chakra%20UI-purple?style=for-the-badge&logo=react" />
  <img src="https://img.shields.io/badge/Dil-TK%20%7C%20TR%20%7C%20EN%20%7C%20RU-orange?style=for-the-badge" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Lisans-AGPL--3.0-red?style=flat-square" />
  <img src="https://img.shields.io/badge/Wersiýa-0.8.4-brightgreen?style=flat-square" />
  <img src="https://img.shields.io/badge/Xray--core-Goldanylýar-blue?style=flat-square" />
</p>

---

## 📋 Mazmuny

- [Barada](#-barada)
- [Esasy Aýratynlyklar](#-esasy-aýratynlyklar)
- [Talap edilýän zatlar](#-talap-edilýän-zatlar)
- [Çalt Gurnamak](#-çalt-gurnamak)
- [El bilen Gurnamak](#-el-bilen-gurnamak)
- [Telegram Bot we Mini App](#-telegram-bot-we-mini-app)
- [Google Drive Ýedeklemek](#-google-drive-ýedeklemek)
- [Goldanýan Protokollar](#-goldanýan-protokollar)
- [Dil Goldawy](#-dil-goldawy)
- [Kömek we Habarlaşmak](#-kömek-we-habarlaşmak)
- [Lisans](#-lisans)

---

## 🏠 Barada

**TM BEGO** — bu Xray-core esasynda işleýän professional VPN dolandyryş panelidir. Modern web interfeýs, Telegram bot integrasiýasy, Google Drive awtomatiki ýedeklemek we köp dilli goldaw bilen üpjün edilendir.

**Esasy maksady:** VPN hyzmatlaryňyzy aňsat we professional derejede dolandyrmak, müşderileriňize iň ýokary tizlik, howpsuzlyk we elýeterlilik hödürlemek.

---

## ✨ Esasy Aýratynlyklar

### 🖥️ Dashboard (Dolandyryş Paneli)
- 🎨 **Premium UI** — Glassmorphism dizaýny, gije/gündiz režimi
- 📊 **Real-time statistika** — Ulanyjylar, traffik, serwerler
- 👥 **Ulanyjy dolandyryşy** — Döretmek, üýtgetmek, pozmak, QR kod generasiýasy
- 🔐 **RBAC** — Granular rugsat dolandyryşy (Node, Sistem, Admin we ş.m.)
- 📱 **Responsive dizaýn** — Telefon, planşet we kompýuter üçin

### 🤖 Telegram Integrasiýasy
- 🔗 **Telegram Bot** — Ulanyjylaryňyza awtomatik subskripsiýa bermek
- 📲 **Mini App** — Telegram-dan göni subskripsiýa dolandyryşy
- 🔒 **Passwordless Auth** — Telegram ID bilen awtomatik giriş

### ☁️ Google Drive Ýedeklemek
- 📁 **Awtomatik ýedeklemek** — Subskripsiýa maglumatlaryny Google Drive-a ýüklemek
- ⚡ **Admin panelinden dolandyrmak** — Ýükleme, sinhronizasiýa, sazlamalar
- 🔑 **Service Account** — Howpsuz OAuth2 autentifikasiýa

### 🌐 Multi-node Goldawy
- 🖧 **Birnäçe serwer** — Dürli ýurtlardaky serwerleri birleşdiriň
- 📈 **Node statistikasy** — Her serweriň ulanylşyny yzarlaň
- 🔄 **Awtomatik ýenilenmek** — Serwer ýagdaýyny real-time yzarlamak

---

## 📦 Talap Edilýän Zatlar

| Talap | Wersiýa |
|-------|---------|
| **OS** | Ubuntu 20.04+ / Debian 11+ |
| **Docker** | 20.10+ |
| **Docker Compose** | v2.0+ |
| **RAM** | 1 GB (minimum) |
| **Disk** | 10 GB (minimum) |
| **Port** | 443, 80 (açyk bolmaly) |

---

## 🚀 Çalt Gurnamak

Ulgamyňyza bir buýruk bilen guruň:

```bash
sudo bash -c "$(curl -sL https://raw.githubusercontent.com/tmbego/tmbego-panel/master/install.sh)"
```

Ýa-da el bilen:

```bash
git clone https://github.com/tmbego/tmbego-panel.git
cd tmbego-panel
sudo bash install.sh
```

Skript size aşakdaky soraglary berer:
1. **Sudo admin ady** — Baş dolandyryjy ady
2. **Sudo admin paroly** — Howpsuz parol
3. **Telegram Bot Token** — @BotFather-dan alyň (hökmany däl)
4. **Telegram Admin ID** — Öz Telegram ID-ňiz (hökmany däl)

---

## 🔧 El Bilen Gurnamak

### 1. Repozitoriýany klonlaň

```bash
git clone https://github.com/tmbego/tmbego-panel.git
cd tmbego-panel
```

### 2. `.env` faýlyny dörediň

```bash
cp .env.example .env
nano .env
```

Hökmany sazlamalar:

```env
SUDO_USERNAME=admin
SUDO_PASSWORD=sizin_parolyňyz
UVICORN_HOST=0.0.0.0
UVICORN_PORT=8000

# Telegram (hökmany däl)
TELEGRAM_API_TOKEN=botfather_dan_alynan_token
TELEGRAM_ADMIN_ID=sizin_telegram_id

# Google Drive (hökmany däl)
GOOGLE_DRIVE_CREDENTIALS_PATH=./data/credentials.json
GOOGLE_DRIVE_FOLDER=TM_BEGO_Backups
```

### 3. Docker Compose bilen başladyň

```bash
docker compose up -d
```

### 4. Dashboard-a giriň

Brauzeriňizi açyň we aşakdaky URL-e giriň:

```
https://your-server-ip:8000/dashboard/
```

---

## 🤖 Telegram Bot we Mini App

### Bot Sazlamalary

1. **@BotFather** bilen täze bot dörediň
2. Bot Token-i alyň
3. TM BEGO dashboard → **Telegram Mini App** sahypasyna giriň
4. Token we Admin ID-ni ýazyň we ýatda saklaň

### Mini App Sazlamalary

1. @BotFather-da `/newapp` buýrugyny ulanyn
2. Web App URL-ni goýuň: `https://your-server/miniapp`
3. Ulanyjylar Telegram-dan göni subskripsiýalaryny dolandyryp bilerler

---

## ☁️ Google Drive Ýedeklemek

### Sazlamak

1. [Google Cloud Console](https://console.cloud.google.com/) -da Service Account dörediň
2. JSON key faýlyny ýükläp alyň
3. TM BEGO dashboard → **Google Drive** sahypasyna giriň
4. Credentials faýlyny ýükläň we papka adyny goýuň
5. **Sinhronizasiýa** düwmesine basyň

---

## 🌐 Goldanýan Protokollar

| Protokol | Goldaw | Düşündiriş |
|----------|--------|------------|
| **VLESS** | ✅ | Iň täze, ýokary tizlikli protokol |
| **VMess** | ✅ | Giňden ulanylýan, ygtybarly protokol |
| **Trojan** | ✅ | TLS esasly, ýüze çykarylmaga garşy |
| **Shadowsocks** | ✅ | Ýönekeý we çalt proksi protokol |
| **WireGuard** | ✅ | Döwrebap, ýokary tizlikli VPN |

### Goldanýan Transport Görnüşleri:
- TCP, WebSocket, gRPC, HTTP/2, QUIC, KCP

---

## 🗣️ Dil Goldawy

| Dil | Kod | Ýagdaý |
|-----|-----|--------|
| 🇹🇲 Türkmen | `tk` | ✅ Doly goldaw |
| 🇹🇷 Türk | `tr` | ✅ Doly goldaw |
| 🇬🇧 Iňlis | `en` | ✅ Doly goldaw |
| 🇷🇺 Rus | `ru` | ✅ Doly goldaw |

Dashboard-yň ýokarky menýusyndan dili üýtgedip bilersiňiz.

---

## 📁 Proýekt Gurluşy

```
tmbego-panel/
├── app/
│   ├── dashboard/          # React frontend (Chakra UI)
│   │   ├── src/
│   │   │   ├── pages/      # Dashboard, Login, HomePage, MiniApp...
│   │   │   ├── components/ # Sidebar, Header, UsersTable...
│   │   │   └── locales/    # Dil faýllary (tk, tr, en, ru)
│   │   └── build/          # Gurlan frontend
│   ├── routers/            # FastAPI endpointleri
│   ├── models/             # SQLAlchemy modelleri
│   ├── google_drive_manager.py  # Google Drive integrasiýasy
│   └── aiogoogle/          # Async Google API kütüphanasy
├── config.py               # Ulgam sazlamalary
├── main.py                 # Giriş nokady
├── docker-compose.yml      # Docker sazlamalary
├── install.sh              # Awtomatik gurnamak skripti
└── requirements.txt        # Python baglylyklary
```

---

## 🛡️ Howpsuzlyk

- 🔐 **JWT** autentifikasiýa
- 🔑 **Bcrypt** parol şifrleme
- 🛡️ **RBAC** — Rol esasly giriş dolandyryşy
- 🔒 **TLS/SSL** goldawy
- 🚫 **CORS** goragy

---

## 📞 Kömek we Habarlaşmak

| Aragatnaşyk | Salgysy |
|-------------|---------|
| 📬 Telegram | [@tmbego_support](https://t.me/tmbego_support) |
| 🐛 Meseleler | [GitHub Issues](https://github.com/tmbego/tmbego-panel/issues) |
| 📖 Wiki | [GitHub Wiki](https://github.com/tmbego/tmbego-panel/wiki) |

---

## 📜 Lisans

Bu proýekt **AGPL-3.0** lisanziýasy astynda paýlanýar. Jikme-jik maglumat üçin [LICENSE](LICENSE) faýlyna serediň.

---

<p align="center">
  <b>🇹🇲 TM BEGO — Professional VPN Dolandyryş Platformasy</b><br/>
  <sub>Xray-core ⚡ FastAPI ⚡ React ⚡ Docker</sub>
</p>
