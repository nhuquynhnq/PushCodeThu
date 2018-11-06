USE QUANLYGIAIBONGDA
--Cau 1
SELECT ct.MACT as [Mã cầu thủ], ct.HOTEN as [Họ Tên],ct.NGAYSINH as[Ngày Sinh],ct.DIACHI as [Địa chỉ],ct.VITRI as [Vị trí]
FROM  CAULACBO clb join CAUTHU ct on ct.MACLB = clb.MACLB 
WHERE ct.MACLB like 'SDN' and ct.MAQG like 'BRA'
--Cau 2
SELECT ct.HOTEN
FROM CAUTHU ct join THAMGIA tg on ct.MACT = tg.MACT
WHERE tg.SOTRAI >=2
GROUP BY ct.HOTEN
--Cau 3
SELECT td.MATRAN,svd.TENSAN,clb.TENCLB as CLB1,cl.TENCLB as CLB2,td.NGAYTD,td.KETQUA
FROM SANVD svd join TRANDAU td on td.MASAN = svd.MASAN join CAULACBO clb on td.MACLB1 = clb.MACLB join CAULACBO cl on td.MACLB2 = cl.MACLB
WHERE td.VONG = 3 and td.NAM = 2009

--Cau 4
SELECT hlv.MAHLV,hlv.TENHLV,hlv.NGAYSINH,hlv.DIACHI,hlcl.VAITRO,clb.TENCLB
FROM HLV_CLB hlcl join HUANLUYENVIEN hlv on hlcl.MAHLV = hlv.MAHLV join CAULACBO clb on hlcl.MACLB = clb.MACLB
WHERE hlv.MAQG like 'VN'
--Cau 5
SELECT clb.MACLB,Count(ct.MACT) as SOLUONGCT
FROM QUOCGIA qg join CAUTHU ct on qg.MAQG = ct.MAQG join CAULACBO clb on ct.MACLB = clb.MACLB join SANVD svd on clb.MASAN = svd.MASAN
WHERE ct.MAQG != 'VN'
GROUP BY clb.MACLB
HAVING Count(ct.MACT)>=2

--Cau 6
SELECT t.TENTINH ,Count(ct.MACT) as SOLUONGCT
FROM CAUTHU ct join CAULACBO clb on ct.MACLB = clb.MACLB join TINH t on clb.MATINH = t.MATINH
WHERE ct.VITRI like N'Tiền đạo' 
GROUP BY t.TENTINH
--Cau 7
SELECT TOP 1 bxh.MACLB,t.TENTINH
FROM BANGXH bxh join CAULACBO clb on bxh.MACLB = clb.MACLB join TINH t on clb.MATINH = t.MATINH 
WHERE bxh.VONG = 3 and bxh.NAM = 2009
--Cau 8
SELECT hlv.TENHLV
FROM HUANLUYENVIEN hlv join HLV_CLB hlcl on hlv.MAHLV = hlcl.MAHLV
WHERE hlv.DIENTHOAI = '' and hlcl.VAITRO != ''
--Cau 9
SELECT hlv.TENHLV
FROM HUANLUYENVIEN hlv
WHERE hlv.MAQG = 'VN' and hlv.MAHLV not in(
SELECT HLV_CLB.MAHLV
FROM HLV_CLB

)
--Cau 10
--Cau 11
SELECT distinct td.MATRAN,svd.TENSAN,clb.TENCLB as CLB1,cl.TENCLB as CLB2,td.NGAYTD,td.KETQUA
FROM SANVD svd join TRANDAU td on td.MASAN = svd.MASAN join CAULACBO clb on td.MACLB1 = clb.MACLB join CAULACBO cl on td.MACLB2 = cl.MACLB join BANGXH bxh on bxh.MACLB = cl.MACLB
WHERE bxh.VONG = 3 and bxh.NAM = 2009 and bxh.HANG=1

--SELECT  bxh.MACLB
--FROM BANGXH bxh join CAULACBO clb on bxh.MACLB = clb.MACLB join TINH t on clb.MATINH = t.MATINH 
--WHERE bxh.VONG = 3 and bxh.NAM = 2009 and bxh.HANG=1

--)
--cau 21--
SELECT clb.MACLB,clb.TENCLB,cl.MACLB ,cl.TENCLB
FROM CAULACBO clb join TRANDAU td on clb.MACLB = td.MACLB1 join CAULACBO cl on cl.MACLB = td.MACLB2
WHERE clb.MACLB in(
SELECT clb.MACLB
FROM BANGXH bxh join CAULACBO clb  on bxh.MACLB = clb.MACLB 
WHERE bxh.SOTRAN=4
)and cl.MACLB in(
SELECT cl.MACLB
FROM BANGXH bxh join CAULACBO cl  on bxh.MACLB = cl.MACLB
WHERE  bxh.SOTRAN=4

)
--Cau 22--
SELECT clb.MACLB,clb.TENCLB
FROM CAULACBO clb join TRANDAU td on clb.MACLB = td.MACLB1 join CAULACBO cl on cl.MACLB = td.MACLB2 join SANVD svd on svd.MASAN = td.MASAN
WHERE td.VONG=1 and td.VONG=2 and td.VONG=3 and td.VONG=4 and clb.MASAN like N'NT' and clb.MACLB in(
SELECT clb.MACLB
FROM BANGXH bxh join CAULACBO clb  on bxh.MACLB = clb.MACLB 
WHERE bxh.SOTRAN=4 
)and cl.MASAN = td.MASAN and cl.MACLB in(
SELECT cl.MACLB
FROM BANGXH bxh join CAULACBO cl  on bxh.MACLB = cl.MACLB
WHERE  bxh.SOTRAN=4

)