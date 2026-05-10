# Docker setup for Laravel / CodeIgniter (Compy 2)

## Ringkas
Setup ini menjalankan aplikasi PHP (Laravel/CodeIgniter) di kontainer `app` dan database MySQL, plus phpMyAdmin.

## Yang sudah tersedia di image
- PHP 8.4 (FPM + Apache) dari image `shinsenter/php:8.4-fpm-apache-alpine`.
- Alpine Linux base image.
- Node.js + npm (versi mengikuti repository Alpine).
- `pnpm` (global).
- `fish` shell.
- MySQL 8.4.5 (service terpisah di docker-compose).

Catatan: Composer sudah tersedia. Cek dengan `composer -V`.

## Layanan dan port
- `app`: 80 (HTTP), 443 (HTTPS), 5173 (Vite dev server)
- `mysql`: 3306
- `phpmyadmin`: 8080

## Cara pakai (Laravel / CodeIgniter)
1. Taruh `Dockerfile` dan `docker-compose.yml` di root project Laravel/CodeIgniter.
2. Pastikan source code project ada di folder yang sama (akan di-mount ke `/var/www/html`).
3. Jalankan container:
   ```bash
   docker compose up -d
   ```
4. Hentikan dan hapus container:
   ```bash
   docker compose down
   ```

## Masuk ke container
Masuk ke container dan gunakan `fish`:
```bash
docker compose exec app fish
```

## Menjalankan Vite / asset build
Pilih salah satu (npm atau pnpm):
```bash
# npm
npm install
npm run dev

# pnpm
pnpm install
pnpm run dev
```

Jika Vite berjalan, akses di `http://localhost:5173`.

## Cek versi tool di container
```bash
php -v
node -v
npm -v
pnpm -v
composer -V
mysql --version
```

## Konfigurasi penting
- Working dir: `/var/www/html`
- Document root (Apache): `/var/www/html/public`
- Volume cache:
  - `~/.composer` -> `/root/.composer`
  - `~/.npm` -> `/root/.npm`
  - `~/.local/share/pnpm` -> `/root/.local/share/pnpm`

## Database
- MySQL 8.4.5, password root kosong (hanya untuk dev).
- phpMyAdmin tersedia di `http://localhost:8080`.

Contoh konfigurasi `.env` (Laravel/CodeIgniter):
```env
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=app
DB_USERNAME=root
DB_PASSWORD=
```

## Permission dan ownership
Jika ada masalah write permission, samakan UID/GID host dengan `PUID`/`PGID` atau set ownership di container:
```bash
chown -R 1000:1000 /var/www/html
```

## Saran penggunaan
- Jika mau versi Node tertentu (mis. Node 24, npm 11), update Dockerfile untuk install versi spesifik.
- Password MySQL kosong hanya untuk development, ganti untuk production.
