-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2019 at 04:57 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ebuy`
--

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `id` int(11) NOT NULL,
  `cardNumber` varchar(250) NOT NULL,
  `ccv` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `userEmail` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `cardNumber`, `ccv`, `month`, `year`, `userEmail`) VALUES
(3, '4444444444444444', 444, 1, 19, 'kk@kk.com');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `message` varchar(250) NOT NULL,
  `user` varchar(250) NOT NULL,
  `seller` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `message`, `user`, `seller`) VALUES
(1, 'kkkkkk', 'kk@kk.com', 0),
(2, 'ff', 'kk@kk.com', 1),
(3, 'kkkkkk', 'kk@kk.com', 0),
(4, 'kkkkkk', 'kk@kk.com', 0),
(5, 'kkkkkk', 'kk@kk.com', 0),
(6, 'kkkkkk', 'kk@kk.com', 0),
(7, 'kkkkkk', 'kk@kk.com', 0),
(8, 'f', 'kk@kk.com', 0),
(9, 'kkkkkk', 'kk@kk.com', 0),
(10, 'ggg', 'kk@kk.com', 0),
(11, 'ggg', 'keudaz@yahoo.com', 1),
(12, 'ggg', 'kk@kk1.com', 1),
(13, '1', 'kk@kk1.com', 1),
(14, 'ffff', 'keudaz@yahoo.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `amount` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `cardNumber` varchar(250) NOT NULL,
  `user` varchar(250) NOT NULL,
  `cancel` int(11) NOT NULL,
  `refund` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id`, `productID`, `name`, `amount`, `quantity`, `cardNumber`, `user`, `cancel`, `refund`) VALUES
(1, 1, '', 10, 1, '4444444444444444', 'kk@kk.com', 2, 2),
(2, 1, 'aaas', 10, 1, '4444444444444444', 'kk@kk.com', 2, 2),
(3, 1, 'aaas', 10, 1, '4444444444444444', 'kk@kk.com', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `price` double NOT NULL,
  `category` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `price`, `category`, `quantity`) VALUES
(3, 'adad', 10, 3, 1),
(4, 'kk', 100, 2, 20),
(5, 'kk', 100, 3, 20),
(6, 'kk', 100, 4, 20),
(7, 'kk', 100, 5, 20);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fname` varchar(250) NOT NULL,
  `lname` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `admin` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fname`, `lname`, `email`, `password`, `admin`) VALUES
(1, 'k', 'l', 'kk@kk.com', '1', 2),
(2, 'k', 'l', 'gg@gg.com', '1', NULL),
(3, 'k', 'l', 'kk@kk1.com', '1', NULL),
(4, 'k', 'l', 'kk@kk12.com', '123456', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
