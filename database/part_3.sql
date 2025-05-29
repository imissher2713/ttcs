CREATE TABLE part3 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    de_thi_id INT,
    so_thu_tu INT,
    audio VARCHAR(255),
    doan_hoi_thoai TEXT,
    cau_hoi TEXT,
    option1 TEXT,
    option2 TEXT,
    option3 TEXT,
    option4 TEXT,
    dap_an_dung CHAR(1),
    FOREIGN KEY (de_thi_id) REFERENCES de_thi(id) ON DELETE CASCADE
);