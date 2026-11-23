# Analisis Produk dan Penjualan TheLook E-commerce dengan SQL

Ini mini project SQL pertama saya di Data Analytics Bootcamp (Sesi 5: Basic SQL sampai Simple JOIN). Semua query saya jalankan di Google BigQuery.

## Tujuan Project

Di project ini saya berperan sebagai Junior Data Analyst di toko online TheLook. Tim bisnis punya tiga pertanyaan:

- Produk apa saja yang dijual, dan seperti apa ciri-cirinya?
- Siapa saja pelanggan yang sudah memesan?
- Kategori produk mana yang paling banyak menghasilkan uang?

Saya menjawab pertanyaan-pertanyaan itu dengan query SQL.

## Dataset

Saya memakai dataset publik **`bigquery-public-data.thelook_ecommerce`** di Google BigQuery. Isinya data buatan (sintetis) dari sebuah toko fashion online, jadi siapa pun bisa memakainya untuk latihan.

| Tabel | Isinya | Kolom yang saya pakai |
|---|---|---|
| `products` | Daftar produk | `id`, `name`, `category`, `department`, `brand`, `retail_price` |
| `users` | Data pelanggan | `id`, `first_name`, `last_name` |
| `orders` | Data pesanan | `order_id`, `user_id`, `status`, `created_at` |
| `order_items` | Barang di dalam setiap pesanan | `product_id`, `sale_price`, `status` |

## Isi Repository

```
.
├── README.md
└── mini_project_sesi5.sql   # semua query untuk soal 1 sampai 5
```

## Pertanyaan Bisnis

| No | Pertanyaan | Materi SQL |
|---|---|---|
| 1 | Seperti apa produk yang dijual? (cukup 20 produk pertama) | `SELECT`, `FROM`, `LIMIT` |
| 2 | Produk mana yang termasuk premium (harga di atas $100)? | `WHERE`, `ORDER BY`, `DESC` |
| 3 | Kategori mana yang punya produk paling banyak? | `COUNT`, `GROUP BY`, `ORDER BY` |
| 4 | Siapa pelanggan yang memesan, dan bagaimana status pesanannya? | `INNER JOIN`, `ON`, alias tabel |
| 5 | Kategori mana yang penjualannya paling besar? | `JOIN`, `SUM`, `GROUP BY`, `ORDER BY` |

query bisa dilihat di [`mini_project_sesi5.sql`](mini_project_sesi5.sql).


### Hasil singkat soal 1, 2, dan 4

- **Soal 1:** 20 produk pertama isinya topi (kategori *Accessories*, merek MG) dan baju renang (kategori *Swim*, merek MW). Harganya mulai sekitar $6 sampai $55.
- **Soal 2:** ada **4.002 produk** dengan harga di atas $100. Yang paling mahal harganya $999, yaitu *Alpha Industries Rip Stop Short* dan *Darla*. Produk premium paling banyak ada di kategori *Outerwear & Coats* (751 produk) dan *Jeans* (739 produk).
- **Soal 4:** setelah tabel `orders` dan `users` saya gabungkan, kita bisa melihat nama pelanggan di samping status pesanannya (*Complete*, *Shipped*, *Processing*, *Cancelled*, atau *Returned*).

### Soal 3: Jumlah produk per kategori (5 teratas dari 26 kategori)

| Peringkat | Kategori | Jumlah Produk |
|---|---|---|
| 1 | Intimates | 2.363 |
| 2 | Jeans | 1.999 |
| 3 | Tops & Tees | 1.868 |
| 4 | Fashion Hoodies & Sweatshirts | 1.866 |
| 5 | Swim | 1.798 |

Total ada 29.120 produk di katalog.

### Soal 5: Total penjualan per kategori (5 teratas)

| Peringkat | Kategori | Total Penjualan (USD) | Penjualan yang Complete saja (USD) |
|---|---|---|---|
| 1 | Outerwear & Coats | 1.317.917,00 | 340.717,25 |
| 2 | Jeans | 1.258.925,98 | 315.152,74 |
| 3 | Sweaters | 832.788,20 | 208.951,31 |
| 4 | Suits & Sport Coats | 651.264,95 | 159.224,02 |
| 5 | Fashion Hoodies & Sweatshirts | 639.156,73 | 164.639,16 |

Kalau semua kategori dijumlahkan, total penjualannya $10.834.169,23.

### Insight Bisnis

**1. Produk banyak belum tentu penjualannya besar.**
*Intimates* punya produk paling banyak (2.363 produk, sekitar 8% dari katalog). Tapi penjualannya cuma ada di peringkat 11, sekitar 4% dari total. *Outerwear & Coats* justru kebalikannya: jumlah produknya peringkat 11 (1.420 produk), tapi penjualannya paling besar, yaitu $1,32 juta atau sekitar 12% dari total.

Kalau saya rata-rata, satu produk *Outerwear & Coats* menghasilkan sekitar $928. Satu produk *Intimates* cuma sekitar $195, hampir 5 kali lebih kecil. Menurut saya ini karena harga jaket dan mantel jauh lebih mahal daripada pakaian dalam. Jadi yang lebih berpengaruh ke penjualan adalah harga per barang, bukan banyaknya pilihan produk.

**2. Sebagian besar uang datang dari sedikit kategori.**
Dari 26 kategori, 5 kategori teratas sudah menyumbang sekitar **43%** dari total penjualan. *Outerwear & Coats* dan *Jeans* juga kategori yang punya produk premium paling banyak di soal 2. Kalau tim Marketing mau bikin kampanye produk premium, dua kategori ini pilihan yang paling masuk akal, dan stoknya perlu dijaga supaya tidak kosong.

**3. Baru sekitar 25% penjualan yang benar-benar selesai.**
Query soal 5 menghitung semua barang yang dipesan, termasuk yang masih dikirim, dibatalkan, atau dikembalikan. Saya menambahkan satu query bonus yang hanya menghitung pesanan berstatus *Complete*. Hasilnya $2,73 juta dari total $10,83 juta, atau sekitar 25%. Urutan kategorinya hampir sama, jadi kesimpulan soal kategori terlaris tetap berlaku. Tapi angka $10,83 juta itu belum bisa dianggap sebagai uang yang sudah masuk ke toko.

## Rekomendasi

- Fokuskan kampanye produk premium ke *Outerwear & Coats* dan *Jeans*.
- Cek ulang katalog *Intimates*. Produknya banyak tapi sumbangannya ke penjualan kecil. Mungkin ada produk yang jarang laku dan bisa dikurangi, atau dijual dalam paket (bundling) dan diberi promo.
- Untuk analisis berikutnya, saya ingin menghitung berapa persen pesanan yang dibatalkan atau dikembalikan di setiap kategori. Dari situ kita bisa tahu kategori mana yang paling banyak kehilangan penjualan.

## Tools

- Google BigQuery (Standard SQL)
- GitHub
