-- Mini Project SQL Sesi 5 - TheLook E-commerce
-- Dataset: bigquery-public-data.thelook_ecommerce

-- 1. Melihat 20 produk pertama beserta kategori, merek, dan harganya
SELECT
  name         AS nama_produk,
  category     AS kategori,
  department,
  brand        AS merek,
  retail_price AS harga_retail
FROM `bigquery-public-data.thelook_ecommerce.products`
LIMIT 20;


-- 2. Mencari produk premium (harga di atas 100), dari yang paling mahal
SELECT
  name         AS nama_produk,
  category     AS kategori,
  brand        AS merek,
  retail_price AS harga_retail
FROM `bigquery-public-data.thelook_ecommerce.products`
WHERE retail_price > 100
ORDER BY retail_price DESC;


-- 3. Menghitung jumlah produk di tiap kategori, dari yang paling banyak
SELECT
  category  AS kategori,
  COUNT(id) AS jumlah_produk
FROM `bigquery-public-data.thelook_ecommerce.products`
GROUP BY category
ORDER BY jumlah_produk DESC;


-- 4. Menampilkan pesanan beserta nama pelanggan yang memesan
SELECT
  o.order_id,
  o.status      AS status_pesanan,
  o.created_at  AS tanggal_pesanan,
  u.first_name  AS nama_depan,
  u.last_name   AS nama_belakang
FROM `bigquery-public-data.thelook_ecommerce.orders` AS o
INNER JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
  ON o.user_id = u.id
ORDER BY o.created_at DESC
LIMIT 100;


-- 5. Menghitung total penjualan di tiap kategori, dari yang paling besar
SELECT
  p.category                    AS kategori,
  ROUND(SUM(oi.sale_price), 2)  AS total_penjualan
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
INNER JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
  ON oi.product_id = p.id
GROUP BY p.category
ORDER BY total_penjualan DESC;


-- Bonus: sama seperti soal 5, tapi hanya pesanan yang sudah selesai (Complete)
SELECT
  p.category                    AS kategori,
  ROUND(SUM(oi.sale_price), 2)  AS total_penjualan_complete
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
INNER JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
  ON oi.product_id = p.id
WHERE oi.status = 'Complete'
GROUP BY p.category
ORDER BY total_penjualan_complete DESC;
