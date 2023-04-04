Create database QLBanHang
use QLBanHang
go
Create table Sanpham
(
masp nchar(10) primary key,
mahangsx nchar(10),
tensp nvarchar(20),
soluong int,
mausac nvarchar(20),
giaban money,
donvitinh nchar(10),
mota nvarchar (max)
)
Create table Hangsx
(
mahangsx nchar(10) primary key,
tenhang nvarchar(20),
diachi nvarchar(30),
sodt nvarchar(20),
email nvarchar(30)
)
Create table Nhanvien
(
manv nchar(10) primary key,
tennv nvarchar(20),
gioitinh nchar(10),
diachi nvarchar(30),
sodt nvarchar(20),
email nvarchar(30),
phong nvarchar(30)
)
Create table Nhap
(
sohdn nchar(10) primary key,
masp nchar(10),
manv nchar(10),
ngaynhap date,
soluongN int,
dongiaN money
)
Create table Xuat
(
sohdx nchar(10),
masp nchar(10),
manv nchar(10),
ngayxuat date,
soluongX int,
primary key (sohdx, masp)
)
ALTER TABLE Sanpham
ADD CONSTRAINT FK_mahangsx
FOREIGN KEY (mahangsx) REFERENCES Hangsx(mahangsx)

ALTER TABLE Nhap
ADD CONSTRAINT FK_masp
FOREIGN KEY (masp) REFERENCES Sanpham(masp)

ALTER TABLE Nhap
ADD CONSTRAINT FK_manv
FOREIGN KEY (manv) REFERENCES Nhanvien(manv)

ALTER TABLE Xuat
ADD CONSTRAINT FK_maspxuat
FOREIGN KEY (masp) REFERENCES Sanpham(masp)

ALTER TABLE Xuat
ADD CONSTRAINT FK_manvxuat
FOREIGN KEY (manv) REFERENCES Nhanvien(manv)

insert into Hangsx
values ('H01','samsung','Korea','011-08271717','ss@gmail.com.kr')
insert into Hangsx
values('H02','oppo','China','081-08626262','oppo@gmail.com.cn')
insert into Hangsx
values('H03','vinfone','Việt Nam','084-098262626','vf@gmail.com.vn')

insert into Nhanvien
values ('NV01','Nguyễn Thị Thu','nữ','Hà Nội','0982626521','thu@gmail.com','kế toán')
insert into Nhanvien
values('NV02','Lê Văn Nam','nam','Bắc Ninh','09722525252','nam@gmail.com','vật tư')
insert into Nhanvien
values('NV03','Trần Hòa Bình','nữ','Hà Nội','0328388388','hb@gmail.com','kế toán')

insert into Sanpham
values ('SPV01','H02','F1 Plus','100','xám','7000000','chiếc','hang cận cao cấp')
insert into Sanpham
values('SP02','H01','Galaxy Note 11','300','đỏ','19000000','chiếc','hàng cao cấp')
insert into Sanpham
values('SP03','H02','F3 lite','200','nâu','3000000','chiếc','hàng phổ thông')
insert into Sanpham
values('SP04','H03','Vjoy3','200','xám','1500000','chiếc','hàng phổ thông')
insert into Sanpham
values('SP05','H01','Galaxy V21','500','nâu','8000000','chiếc','hang cận cao cấp')

insert into Nhap
values ('N01','SP02','NV01','2019-02-05','10','17000000')
insert into Nhap
values ('N02','SP01','NV02','2020-04-07','30','6000000')
insert into Nhap
values ('N03','SP04','NV02','2020-05-17','20','1200000')
insert into Nhap
values ('N04','SP01','NV03','2020-03-22','10','6200000')
insert into Nhap
values ('N05','SP05','NV01','2020-07-07','20','7000000')

insert into Xuat
values ('X01','SP03','NV02','2020-06-14','5')
insert into Xuat
values ('X02','SP01','NV03','2019-03-05','3')
insert into Xuat
values ('X03','SP02','NV01','2020-12-12','1')
insert into Xuat
values ('X04','SP03','NV02','2020-02-06','2')
insert into Xuat
values ('X05','SP05','NV01','2020-05-18','1')

--1) Hiển thị thông tin các bảng dữ liệu--
select*from Hangsx
select*from Nhanvien
select*from Sanpham
select*from Nhap
select*from Xuat

--2) Đưa ra thông tin... của sản phẩm sắp xếp theo chiều giảm dần giá bán--
select masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota
from Sanpham
order by giaban DESC

--3) Đưa ra các thông tin các sản phẩm có trong cửa hàng do công ty Samsung sản xuất--
select masp, tensp, soluong, tenhang
from Sanpham inner join Hangsx on Sanpham.mahangsx = Hangsx.mahangsx
where tenhang='samsung'

--4) Đưa ra thông tin các nhân viên nữ ở phòng Kế Toán--
select manv, tennv, gioitinh, diachi, sodt, email, phong
from Nhanvien
where gioitinh='Nữ'and phong='kế toán'

--5) Đưa ra thông tin phiếu nhập gồm:..., tiennhap=soluongN*dongiaN,...sắp xếp theo chiều tăng dần của hóa đơn nhập--
SELECT sohdn, sanpham.masp, tensp, tenhang, soluongn, dongian, tiennhap=soluongn*dongian mausac, donvitinh, ngaynhap, tennv, phong
FROM nhap
join sanpham ON nhap.masp = sanpham.masp
join hangsx ON sanpham.mahangsx = hangsx.mahangsx
join nhanvien ON nhap.manv = nhanvien.manv
ORDER BY Sohdn ASC

--6) Đưa ra thông tin phiếu xuất gồm:..., tienxuat=soluongX*giaban,... trong tháng 10 năm 2018, sắp xếp theo chiều tăng dần của sohdx--
SELECT DISTINCT sohdx, xuat.masp, tensp, tenhang, soluongx, giaban, tienxuat=soluongx*giaban, mausac, donvitinh, ngayxuat, tennv, phong
FROM xuat
join sanpham ON xuat.masp = sanpham.masp
join hangsx ON sanpham.mahangsx = hangsx.mahangsx
join nhanvien ON xuat.Manv = nhanvien.manv
WHERE YEAR(ngayxuat) = 2018 AND MONTH(ngayxuat) = 10 ORDER BY sohdx ASC

--8) Đưa ra top 10 hóa đơn xuất số lượng nhiều nhất trong năm 2018, sắp xếp theo chiều giảm dần của soluongX--
SELECT TOP 10 *FROM xuat WHERE YEAR(soluongx) = 2018 ORDER BY soluongx ASC

--9) Đưa ra thông tin 10 sản phẩm có giá bán cao nhất trong cửa hàng, theo chiều giảm dần giá bán--
SELECT TOP 10 *FROM sanpham ORDER BY giaban DESC

--10) Đưa ra các thông tin sản phẩm có giá bán từ 1.000.000 đến 5.000.000 của hãng Samsung--
SELECT *FROM sanpham join hangsx ON sanpham.mahangsx = hangsx.mahangsx
WHERE 100000<giaban AND giaban<500000 AND hangsx.tenhang = 'Samsung'
