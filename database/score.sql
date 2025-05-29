CREATE TABLE ket_qua (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    de_thi_id INT,
    so_cau_dung INT,
    tong_so_cau INT,
    diem INT,
    thoi_gian_lam INT, -- tính bằng giây
    ngay_lam DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (de_thi_id) REFERENCES de_thi(id) ON DELETE CASCADE
);