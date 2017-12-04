-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 01, 2016 at 01:24 AM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fedlibrary`
--

-- --------------------------------------------------------

--
-- Table structure for table `borrowings`
--

CREATE TABLE `borrowings` (
  `index` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `user` varchar(100) NOT NULL,
  `date_borrowed` varchar(100) NOT NULL,
  `date_to_return` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `borrowings`
--

INSERT INTO `borrowings` (`index`, `item`, `user`, `date_borrowed`, `date_to_return`, `status`) VALUES
(1, 1, 'spinder@gmail.com', '2010-10-1', '2010-10-2', 'Borrowed'),
(2, 2, 'spinder@gmail.com', '2010-10-1', '2010-10-2', 'Borrowed');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `index` int(11) NOT NULL,
  `ctime` varchar(100) NOT NULL,
  `comment` varchar(500) NOT NULL,
  `item` int(11) NOT NULL,
  `user` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`index`, `ctime`, `comment`, `item`, `user`) VALUES
(1, '2016-10-01     10:03:01', 'awwww!! i love hacking so much.', 2, 'spinder@gmail.com'),
(2, '2016-10-01     10:44:32', 'awww!!! i am interested in learning programming.. <3', 1, 'spinder@gmail.com'),
(3, '2016-10-01     23:23:23', 'nice book', 3, 'harshil@gmail.com'),
(4, '2016-10-01     10:12:12', 'omggg!! i will read it tonight!', 3, 'spinder@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `title` varchar(500) NOT NULL,
  `author` varchar(500) NOT NULL,
  `publisher` varchar(500) NOT NULL,
  `publishdate` varchar(100) NOT NULL,
  `isbn` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `category` varchar(200) NOT NULL,
  `status` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `title`, `author`, `publisher`, `publishdate`, `isbn`, `description`, `category`, `status`) VALUES
(1, 'Programming 1 ', 'Nadil', 'ACS', 'March 2013', '8454545,', 'Written by the renowned professor after years of research in the field of programming in Java, C#, dot net, this book gives the fundamental concepts in a clear form to understand the basics of programming.', 'Programming', 'Available'),
(2, 'Hacking via Kali Linux', 'Greg', 'Greg', 'March, 2014', '00000000', 'World famous hacker has come ahead with all his hacking techniques and secrets which is being shared in this book. Known for his excellent networking skills and brilliant hacking capabilities, you will be able to tell the system vulnerabilities of any system after giving this book a read!', 'Hacking', 'Available'),
(3, 'Modern Networking', 'KT', 'Deepak', 'April, 2015', '11111111111', 'This books gives a very clear and basic understanding of how network works around us. How to setup a network step by step information can also be found in this book. For beginners and advanced, this book caters for everyone!', 'Networking', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `index` int(11) NOT NULL,
  `email` varchar(150) NOT NULL,
  `fname` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `profile` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`index`, `email`, `fname`, `phone`, `password`, `type`, `profile`) VALUES
(5, 'harshil@gmail.com', 'harshil bhandari', '043534343343', 'harshil', 'user', ''),
(6, 'spinder@gmail.com', 'Spinder Singh', '032424242', 'splender', 'user', ''),
(7, 'navneet@gmail.com', 'navneet kaur', '0434343434', 'navneet', 'admin', ''),
(10, 'admin@admin.com', 'Benjamin F. Administrator', '098293020', 'admin', 'admin', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `borrowings`
--
ALTER TABLE `borrowings`
  ADD PRIMARY KEY (`index`),
  ADD KEY `item` (`item`),
  ADD KEY `user` (`user`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`index`),
  ADD KEY `item` (`item`),
  ADD KEY `user` (`user`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`index`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `borrowings`
--
ALTER TABLE `borrowings`
  MODIFY `index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `borrowings`
--
ALTER TABLE `borrowings`
  ADD CONSTRAINT `borrowings_ibfk_1` FOREIGN KEY (`item`) REFERENCES `items` (`id`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`item`) REFERENCES `items` (`id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`item`) REFERENCES `items` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
