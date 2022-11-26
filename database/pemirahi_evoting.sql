-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 15, 2022 at 05:15 AM
-- Server version: 5.7.37
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pemirahi_evoting`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_calon`
--

CREATE TABLE `tb_calon` (
  `id_calon` int(11) NOT NULL,
  `nama_calon` varchar(100) DEFAULT NULL,
  `foto_calon` varchar(200) DEFAULT NULL,
  `keterangan` blob,
  `status` enum('0','1') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tb_daftarvote`
--

CREATE TABLE `tb_daftarvote` (
  `daftarvote_id` int(11) NOT NULL,
  `nama` varchar(150) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `tanggal_mulai` datetime DEFAULT NULL,
  `tanggal_selesai` datetime DEFAULT NULL,
  `status_id` enum('0','1','2') DEFAULT NULL,
  `flag_id` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tb_pengguna`
--

CREATE TABLE `tb_pengguna` (
  `id_pengguna` int(11) NOT NULL,
  `nama_pengguna` varchar(100) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `level` enum('Administrator','Petugas','Pemilih') DEFAULT NULL,
  `status` enum('1','0') DEFAULT NULL,
  `jenis` enum('PAN','PST') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tb_pengguna`
--

INSERT INTO `tb_pengguna` (`id_pengguna`, `nama_pengguna`, `username`, `password`, `level`, `status`, `jenis`) VALUES
(1, 'root', 'root', 'root', 'Administrator', '1', 'PAN'),
(2, 'admin', 'admin', 'admin', 'Petugas', '1', 'PAN');

-- --------------------------------------------------------

--
-- Table structure for table `tb_vote`
--

CREATE TABLE `tb_vote` (
  `id_vote` int(11) NOT NULL,
  `daftarvote_id` int(11) DEFAULT NULL,
  `id_calon` int(2) DEFAULT NULL,
  `id_pemilih` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tb_votekandidat`
--

CREATE TABLE `tb_votekandidat` (
  `votekandidat_id` int(11) NOT NULL,
  `daftarvote_id` int(11) DEFAULT NULL,
  `id_calon` int(11) DEFAULT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `flag_id` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tb_votepemilih`
--

CREATE TABLE `tb_votepemilih` (
  `votepemilih_id` int(11) NOT NULL,
  `daftarvote_id` int(11) DEFAULT NULL,
  `id_pemilih` int(11) DEFAULT NULL,
  `flag_id` tinyint(4) DEFAULT NULL,
  `status_id` enum('1','2') DEFAULT NULL COMMENT '1 = BELUM MEMILIH / 2 = SUDAH MEMILIH'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_vote`
-- (See below for the actual view)
--
CREATE TABLE `v_vote` (
`id_vote` int(11)
,`daftarvote_id` int(11)
,`id_calon` int(2)
,`id_pemilih` int(11)
,`date` datetime
,`nama_calon` varchar(100)
,`foto_calon` varchar(200)
,`keterangan` blob
,`nama_pemilih` varchar(100)
);

-- --------------------------------------------------------

--
-- Structure for view `v_vote`
--
DROP TABLE IF EXISTS `v_vote`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_vote`  AS SELECT `a`.`id_vote` AS `id_vote`, `a`.`daftarvote_id` AS `daftarvote_id`, `a`.`id_calon` AS `id_calon`, `a`.`id_pemilih` AS `id_pemilih`, `a`.`date` AS `date`, `b`.`nama_calon` AS `nama_calon`, `b`.`foto_calon` AS `foto_calon`, `b`.`keterangan` AS `keterangan`, `c`.`nama_pengguna` AS `nama_pemilih` FROM ((`tb_vote` `a` join `tb_calon` `b` on((`a`.`id_calon` = `b`.`id_calon`))) join `tb_pengguna` `c` on((`a`.`id_pemilih` = `c`.`id_pengguna`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_calon`
--
ALTER TABLE `tb_calon`
  ADD PRIMARY KEY (`id_calon`) USING BTREE;

--
-- Indexes for table `tb_daftarvote`
--
ALTER TABLE `tb_daftarvote`
  ADD PRIMARY KEY (`daftarvote_id`) USING BTREE;

--
-- Indexes for table `tb_pengguna`
--
ALTER TABLE `tb_pengguna`
  ADD PRIMARY KEY (`id_pengguna`) USING BTREE,
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `tb_vote`
--
ALTER TABLE `tb_vote`
  ADD PRIMARY KEY (`id_vote`) USING BTREE,
  ADD KEY `daftarvote_id` (`daftarvote_id`),
  ADD KEY `id_calon` (`id_calon`),
  ADD KEY `id_pemilih` (`id_pemilih`);

--
-- Indexes for table `tb_votekandidat`
--
ALTER TABLE `tb_votekandidat`
  ADD PRIMARY KEY (`votekandidat_id`) USING BTREE,
  ADD KEY `daftarvote_id` (`daftarvote_id`),
  ADD KEY `id_calon` (`id_calon`);

--
-- Indexes for table `tb_votepemilih`
--
ALTER TABLE `tb_votepemilih`
  ADD PRIMARY KEY (`votepemilih_id`) USING BTREE,
  ADD KEY `daftarvote_id` (`daftarvote_id`),
  ADD KEY `id_pemilih` (`id_pemilih`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_calon`
--
ALTER TABLE `tb_calon`
  MODIFY `id_calon` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `tb_daftarvote`
--
ALTER TABLE `tb_daftarvote`
  MODIFY `daftarvote_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tb_pengguna`
--
ALTER TABLE `tb_pengguna`
  MODIFY `id_pengguna` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `tb_vote`
--
ALTER TABLE `tb_vote`
  MODIFY `id_vote` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=863;

--
-- AUTO_INCREMENT for table `tb_votekandidat`
--
ALTER TABLE `tb_votekandidat`
  MODIFY `votekandidat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `tb_votepemilih`
--
ALTER TABLE `tb_votepemilih`
  MODIFY `votepemilih_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_vote`
--
ALTER TABLE `tb_vote`
  ADD CONSTRAINT `tb_vote_ibfk_1` FOREIGN KEY (`id_calon`) REFERENCES `tb_calon` (`id_calon`),
  ADD CONSTRAINT `tb_vote_ibfk_2` FOREIGN KEY (`daftarvote_id`) REFERENCES `tb_daftarvote` (`daftarvote_id`),
  ADD CONSTRAINT `tb_vote_ibfk_3` FOREIGN KEY (`id_pemilih`) REFERENCES `tb_pengguna` (`id_pengguna`);

--
-- Constraints for table `tb_votekandidat`
--
ALTER TABLE `tb_votekandidat`
  ADD CONSTRAINT `tb_votekandidat_ibfk_1` FOREIGN KEY (`id_calon`) REFERENCES `tb_calon` (`id_calon`),
  ADD CONSTRAINT `tb_votekandidat_ibfk_2` FOREIGN KEY (`daftarvote_id`) REFERENCES `tb_daftarvote` (`daftarvote_id`);

--
-- Constraints for table `tb_votepemilih`
--
ALTER TABLE `tb_votepemilih`
  ADD CONSTRAINT `tb_votepemilih_ibfk_1` FOREIGN KEY (`daftarvote_id`) REFERENCES `tb_daftarvote` (`daftarvote_id`),
  ADD CONSTRAINT `tb_votepemilih_ibfk_2` FOREIGN KEY (`id_pemilih`) REFERENCES `tb_pengguna` (`id_pengguna`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
