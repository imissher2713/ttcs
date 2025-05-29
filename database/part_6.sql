CREATE TABLE part6 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    de_thi_id INT,
    so_thu_tu INT,
    doan_van TEXT,
    cau_hoi TEXT,
    option1 TEXT,
    option2 TEXT,
    option3 TEXT,
    option4 TEXT,
    dap_an_dung CHAR(1),
    FOREIGN KEY (de_thi_id) REFERENCES de_thi(id) ON DELETE CASCADE
);