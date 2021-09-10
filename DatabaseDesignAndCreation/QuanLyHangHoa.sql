CREATE DATABASE `quan-ly-nhap-xuat`;
USE `quan-ly-nhap-xuat`;

CREATE TABLE `sodienthoai` (
  `SĐT` VARCHAR(10) CHARACTER SET 'utf8' NOT NULL,
  `MaNCC` INT NOT NULL,
  INDEX `fk_sodienthoai_nhacc1_idx` (`MaNCC` ASC),
  PRIMARY KEY (`MaNCC`, `SĐT`),
  CONSTRAINT `fk_sodienthoai_nhacc1`
    FOREIGN KEY (`MaNCC`)
    REFERENCES `quan-ly-nhap-xuat`.`nhacc` (`MaNCC`)
    );

CREATE TABLE `nhacc` (
  `MaNCC` INT NOT NULL,
  `TenNCC` VARCHAR(45) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `DiaChi` VARCHAR(45) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  PRIMARY KEY (`MaNCC`)
  );

CREATE TABLE `dondh` (
  `SoDH` INT NOT NULL,
  `NgayDH` DATE NULL DEFAULT NULL,
  `MaNCC` INT NOT NULL,
  PRIMARY KEY (`SoDH`, `MaNCC`),
  INDEX `fk_dondh_nhacc1_idx` (`MaNCC` ASC) ,
  CONSTRAINT `fk_dondh_nhacc1`
    FOREIGN KEY (`MaNCC`)
    REFERENCES `quan-ly-nhap-xuat`.`nhacc` (`MaNCC`)
    );

CREATE TABLE `vattu` (
  `idVATTU` INT NOT NULL,
  `TenVTU` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idVATTU`));

CREATE TABLE `phieunhap` (
  `SoPN` INT NOT NULL,
  `NgayNhap` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`SoPN`));

CREATE TABLE `thongtinxuat` (
  `SoPX` INT NOT NULL,
  `MaVTU` INT NOT NULL,
  `DGXuat` DECIMAL(10,2) NULL DEFAULT NULL,
  `SLXuat` BIGINT NULL DEFAULT NULL,
  `idVATTU` INT NOT NULL,
  `phieuxuat_SoPX` INT NOT NULL,
  PRIMARY KEY (`idVATTU`, `phieuxuat_SoPX`),
  INDEX `fk_thongtinxuat_phieuxuat1_idx` (`phieuxuat_SoPX` ASC) ,
  CONSTRAINT `fk_thongtinxuat_vattu1`
    FOREIGN KEY (`idVATTU`)
    REFERENCES `quan-ly-nhap-xuat`.`vattu` (`idVATTU`),
  CONSTRAINT `fk_thongtinxuat_phieuxuat1`
    FOREIGN KEY (`phieuxuat_SoPX`)
    REFERENCES `quan-ly-nhap-xuat`.`phieuxuat` (`SoPX`));

CREATE TABLE `phieuxuat` (
  `SoPX` INT NOT NULL,
  `NgayXuat` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`SoPX`));

CREATE TABLE `thongtinnhap` (
  `MaVTU` INT NOT NULL,
  `SoPN` INT NOT NULL,
  `DGNhap` DECIMAL(10,2) NULL DEFAULT NULL,
  `SLNhap` BIGINT NULL DEFAULT NULL,
  `idVATTU` INT NOT NULL,
  PRIMARY KEY (`idVATTU`, `SoPN`),
  INDEX `fk_thongtinnhap_phieunhap1_idx` (`SoPN` ASC) ,
  CONSTRAINT `fk_thongtinnhap_vattu1`
    FOREIGN KEY (`idVATTU`)
    REFERENCES `quan-ly-nhap-xuat`.`vattu` (`idVATTU`),
  CONSTRAINT `fk_thongtinnhap_phieunhap1`
    FOREIGN KEY (`SoPN`)
    REFERENCES `quan-ly-nhap-xuat`.`phieunhap` (`SoPN`));
    
    CREATE TABLE `thongtindh` (
  `SoDH` INT NOT NULL,
  `idVATTU` INT NOT NULL,
  INDEX `fk_thongtindh_dondh1_idx` (`SoDH` ASC) ,
  INDEX `fk_thongtindh_vattu1_idx` (`idVATTU` ASC) ,
  PRIMARY KEY (`SoDH`, `idVATTU`),
  CONSTRAINT `fk_thongtindh_dondh1`
    FOREIGN KEY (`SoDH`)
    REFERENCES `quan-ly-nhap-xuat`.`dondh` (`SoDH`),
  CONSTRAINT `fk_thongtindh_vattu1`
    FOREIGN KEY (`idVATTU`)
    REFERENCES `quan-ly-nhap-xuat`.`vattu` (`idVATTU`));