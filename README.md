# Scratch Projects — Góc ý tưởng

Nơi mọi người trong công ty chia sẻ ý tưởng nhỏ dưới dạng trang web (HTML/CSS/JS) — không cần biết lập trình, chỉ cần nhờ AI viết giúp.

Xem tất cả ý tưởng tại: **https://dev-fromvietnam.github.io/scratch-projects/**

> ⚠️ **Trang này công khai — ai trên Internet cũng xem được.** Tuyệt đối không đưa dữ liệu thật, thông tin khách hàng, mật khẩu hay API key vào.

## Bước 1: Nhờ AI viết trang

Mở Claude hoặc ChatGPT, dán đoạn dưới đây và thay phần `[...]` bằng mô tả ý tưởng của bạn:

```
Hãy giúp tôi làm một trang web nhỏ cho ý tưởng sau:
[Mô tả ý tưởng của bạn, ví dụ: máy tính lương thực nhận từ lương gross]

Yêu cầu bắt buộc:
- Chỉ dùng HTML, CSS, JavaScript thuần, gồm đúng 3 file: index.html, style.css, script.js.
- Liên kết giữa các file dùng đường dẫn tương đối (ví dụ href="style.css", src="script.js").
- Không dùng framework hay thư viện cần cài đặt (không React, không npm...).
- Không gọi API cần key/mật khẩu.
- Không dùng dữ liệu thật hay thông tin khách hàng — chỉ dùng dữ liệu mẫu.
- Có thẻ <title> mô tả ngắn gọn ý tưởng (tiêu đề này sẽ hiện ở trang chủ).
- Thêm một liên kết "← Về trang chủ" với href="../../".
Hãy đưa nội dung đầy đủ của từng file.
```

## Bước 2: Lưu file vào một thư mục

1. Tạo một thư mục mới trên máy.
2. Đặt tên thư mục theo quy tắc: **chỉ chữ thường không dấu, số và dấu gạch ngang** (`-`). Ví dụ: `may-tinh-luong`, `lich-hop-2025`. Không dùng dấu cách, chữ hoa hay tiếng Việt có dấu.
3. Lưu 3 file `index.html`, `style.css`, `script.js` vào thư mục đó.

**Chạy thử trên máy:** nhấp đúp vào `index.html` để mở bằng trình duyệt. Thấy chạy ổn rồi mới tải lên.

## Bước 3: Tải lên GitHub

1. Mở trang repo trên GitHub, bấm vào thư mục **`ideas`**.
2. Bấm **Add file** → **Upload files**.
3. **Kéo thả CẢ THƯ MỤC** (không phải từng file lẻ) vào khung tải lên.
4. Ở cuối trang, chọn **"Create a new branch for this commit and start a pull request"**.
   (Nếu bạn không có quyền ghi, bạn sẽ không thấy lựa chọn này mà chỉ thấy nút **Propose changes** — GitHub tự tạo bản sao "fork" cho bạn. Điều này bình thường, cứ làm tiếp.)
5. Bấm **Propose changes** → ở trang tiếp theo bấm **Create pull request**.

Giới hạn: mỗi file tối đa 25MB, mỗi lần tải lên tối đa 100 file.

## Bước 4: Chờ duyệt

- GitHub sẽ tự kiểm tra. Chờ dấu **✓ xanh**, sau đó người duyệt sẽ xem và merge.
- Nếu phần kiểm tra báo đang chờ duyệt ("awaiting approval" / "waiting") mà không chạy, hãy nhắn admin để họ bấm duyệt cho lượt chạy kiểm tra.
- Vài phút sau khi merge, ý tưởng của bạn xuất hiện tại:
  `https://dev-fromvietnam.github.io/scratch-projects/ideas/<ten-thu-muc>/`

### Khi kiểm tra báo ✗ đỏ

Bấm **Details** bên cạnh dấu đỏ và tìm dòng bắt đầu bằng **`LỖI`**. Thường gặp:

- Tên thư mục sai quy tắc → đổi tên thư mục rồi tải lên lại.
- Thiếu `index.html` → thêm file `index.html` vào thư mục.
- File nằm lẻ ngay trong `ideas/` → bạn đã kéo từng file thay vì cả thư mục; hãy tải lên lại theo đúng thư mục.

---

## Dành cho admin

**Cài đặt một lần:**

1. **Settings → Pages → Source** = **GitHub Actions**.
2. **Settings → Rules → Rulesets → New branch ruleset**, áp dụng cho `main`:
   - Bật **Require a pull request before merging** (1 approval).
   - Bật **Require status checks to pass** → thêm check **`build`**.
     (Check `build` chỉ xuất hiện trong danh sách chọn sau khi workflow đã chạy ít nhất một lần — hãy mở một PR thử trước.)

**Dựng thử trên máy:**

```bash
bash scripts/build-index.sh
```

Rồi mở `_site/index.html` bằng trình duyệt.

Khi duyệt PR, xem checklist trong mẫu pull request (`.github/pull_request_template.md`).
