## Ý tưởng của bạn

<!-- Mô tả ngắn: ý tưởng này làm gì? -->

## Người gửi — kiểm tra trước khi gửi

- [ ] Thư mục nằm trong `ideas/` (ví dụ `ideas/may-tinh-luong/`)
- [ ] Tên thư mục chỉ có chữ thường không dấu, số, dấu gạch ngang
- [ ] Có file `index.html` ngay trong thư mục
- [ ] Không có dữ liệu thật, thông tin khách hàng, mật khẩu hay API key

## Người duyệt — kiểm tra bảo mật

- [ ] `fetch` / `XMLHttpRequest`: gửi dữ liệu đi đâu? (không gửi ra ngoài trái phép)
- [ ] `localStorage` / `document.cookie`: lưu/đọc gì? (Mọi ý tưởng dùng chung một origin trình duyệt, nên localStorage/cookie bị chia sẻ giữa các ý tưởng — ý tưởng này có thể đọc/ghi dữ liệu của ý tưởng khác.)
- [ ] `<script src>` tải từ bên ngoài: nguồn có tin cậy không?
- [ ] Không dùng `eval` / `new Function`
- [ ] Không có form thu thập mật khẩu hay thông tin cá nhân
