-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: csmysql.cs.cf.ac.uk
-- Generation Time: Mar 18, 2021 at 12:11 AM
-- Server version: 10.3.23-MariaDB
-- PHP Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `c21012241_flaskblog2`
--

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `content` text NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `post_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`id`, `date`, `content`, `parent_id`, `post_id`, `author_id`) VALUES
(1, '2021-03-15 18:05:00', 'What a load of old Lorum', NULL, 1, 2),
(2, '2021-03-15 18:43:27', 'Interesting content right here!', NULL, 1, 2),
(3, '2021-03-15 23:51:55', 'Cracking read!', NULL, 3, 2),
(4, '2021-03-17 18:59:11', 'Glad you enjoyed it it Mark :)', NULL, 3, 1),
(5, '2021-03-18 00:06:15', 'Hope you like it!', NULL, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `likers`
--

CREATE TABLE `likers` (
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `title` text NOT NULL,
  `content` text NOT NULL,
  `image_file` varchar(40) NOT NULL,
  `author_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`id`, `date`, `title`, `content`, `image_file`, `author_id`) VALUES
(1, '2021-03-14 16:08:20', 'Lorem ipsum', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ultrices nec sapien in efficitur. Integer et lacus scelerisque, gravida est aliquet, aliquet libero. Nam at turpis rhoncus, mollis nisl ut, elementum nisl. Ut risus eros, convallis nec aliquam eget, vehicula at dui. Nulla pellentesque hendrerit mi sed scelerisque. Curabitur eget lorem non justo laoreet fermentum. Ut posuere ante ac vulputate hendrerit. Maecenas consequat ac augue eget sollicitudin. Proin commodo odio eu nisi pretium, non congue felis pharetra. Proin laoreet tortor malesuada, hendrerit risus et, consectetur purus. Duis ut lacus in orci pellentesque pulvinar vel a lacus. Vivamus laoreet odio ac sem luctus pulvinar.', 'default.jpg', 1),
(2, '2021-03-14 16:10:17', 'A lotta lorem', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ultrices nec sapien in efficitur. Integer et lacus scelerisque, gravida est aliquet, aliquet libero. Nam at turpis rhoncus, mollis nisl ut, elementum nisl. Ut risus eros, convallis nec aliquam eget, vehicula at dui. Nulla pellentesque hendrerit mi sed scelerisque. Curabitur eget lorem non justo laoreet fermentum. Ut posuere ante ac vulputate hendrerit. Maecenas consequat ac augue eget sollicitudin. Proin commodo odio eu nisi pretium, non congue felis pharetra. Proin laoreet tortor malesuada, hendrerit risus et, consectetur purus. Duis ut lacus in orci pellentesque pulvinar vel a lacus. Vivamus laoreet odio ac sem luctus pulvinar.', 'Lorem_Ipsum.jpg', 1),
(3, '2021-03-15 19:28:15', 'Clubhouse in China: Is the data safe?', '<p>Last week, the drop-in audio chat app “Clubhouse” enabled rare unfettered Mandarin-language debate for mainland Chinese iPhone users, before being abruptly blocked by the country’s online censors on Monday February 8, 2021.\r\n</p>\r\n<p>\r\nAlongside casual conversations about travel and health, users frankly discussed Uighur concentration camps in Xinjiang, the 1989 Tiananmen Square protests, and personal experiences of being interrogated by police. The Chinese government restricts open discussion of these topics, maintaining a “Great Firewall” to block domestic audiences from accessing many foreign apps and websites. Although last week Clubhouse had not yet been blocked by the Great Firewall, some mainland users worried the government could eavesdrop on the conversation, leading to reprisals. \r\n</p>\r\n<p>\r\nIn recent years, the Chinese government under President Xi Jinping has shown an increased willingness to prosecute its citizens for speech critical of the regime, even when that speech is blocked in China. Clubhouse app’s audio messages, unlike Twitter posts, leave no public record after speech occurs, potentially complicating Chinese government monitoring efforts.\r\n</p>\r\n<p>\r\nThe Stanford Internet Observatory has confirmed that Agora, a Shanghai-based provider of real-time engagement software, supplies back-end infrastructure to the Clubhouse App (see Appendix). This relationship had previously been widely suspected but not publicly confirmed. Further, SIO has determined that a user’s unique Clubhouse ID number and chatroom ID are transmitted in plaintext, and Agora would likely have access to users’ raw audio, potentially providing access to the Chinese government. In at least one instance, SIO observed room metadata being relayed to servers we believe to be hosted in the PRC, and audio to servers managed by Chinese entities and distributed around the world via Anycast. It is also likely possible to connect Clubhouse IDs with user profiles.\r\n</p>\r\n<p>\r\nSIO chose to disclose these security issues because they are both relatively easy to uncover and because they pose immediate security risks to Clubhouse’s millions of users, particularly those in China. SIO has discovered other security flaws that we have privately disclosed to Clubhouse and will publicly disclose when they are fixed or after a set deadline.\r\n</p>\r\n<p>\r\nFor further reading please see the full article here: <a href=\"https://cyber.fsi.stanford.edu/io/news/clubhouse-china\">https://cyber.fsi.stanford.edu/io/news/clubhouse-china</a>\r\n</p> \r\n', 'clubhouse.jpg', 1),
(5, '2021-03-17 22:47:53', 'Human-Computer Interaction Methodology and its Benefit to Security, Quality, and Usability of Software', '<p>\r\nSecurity, quality, and usability are often at odds when it comes to the development of software development. \r\n</p>\r\n<p>\r\nFrom a user’s perspective, security is rarely the main goal of their interaction with software, perhaps “secondary to completing primary tasks like completing an online banking transaction or ordering medications.” (O\'Reilly Media 2020). During the design of a project, security along with usability are not typically “considered primary goals, making them likely candidates for sacrifice in the rush to meet project deadlines.” (Faily et al. 2015). This is hugely detrimental in the long run from a business perspective. For if the product is going to succeed, any breach of data or lack of usability will be seen in the user’s eyes as a drop in quality of the service/software, and in turn, reflect badly on the business’s reputation and profitability. \r\n</p>\r\n<p>\r\nHistorically security solutions have been predominantly targeted at the technically minded, however with an increasing amount of people’s daily life involving computing technology and their sensitive information, something which has only been exacerbated by the SARS-CoV-2 pandemic, disparate types of users must now be accommodated. To facilitate the integration of these new users, security solutions should not get in the way of the functionality of the product, all the while their purpose and use of data should be as transparent to the user as possible. If both of these requirements can be fulfilled, the user\'s confidence in the quality of the product and the trustworthiness of the brand is bolstered or even raised.\r\n</p>\r\n<p>\r\nA vast number of software development companies now carry out a study of their users through a Human Computer Interaction (HCI) lens during the design stage. The reality of this means developing prototypes, setting out requirements, collecting ongoing data from users, and usability tests with individual users for example. These processes should all be refined, redefined, and validated as an ongoing concern throughout the project. These methodologies and techniques have proven to be hugely beneficial to the outcome of many software projects, increasing the user\'s perceptions of quality and usability. As a result, the security elements are not tacked on, instead are appropriately designed for the people who use them.\r\n</p>\r\n<p>\r\nReferences\r\n</p>\r\n<li>\r\nFaily, S. et al. 2015. Usability and Security by Design: A Case Study in Research and Development. Proceedings 2015 Workshop on Usable Security . Available at: <a href=\"https://www.ndss-symposium.org/wp-content/uploads/2017/09/04_2_3.pdf \">https://www.ndss-symposium.org/wp-content/uploads/2017/09/04_2_3.pdf </a>[Accessed: 16 March 2021].\r\n</li>\r\n<li>\r\nO\'Reilly Media 2020. Four. Usability Design and Evaluation for Privacy and Security Solutions. Available at: <a href=\"https://learning.oreilly.com/library/view/security-and-usability/0596008279/ch04.html\">https://learning.oreilly.com/library/view/security-and-usability/0596008279/ch04.html</a> [Accessed: 16 March 2021].\r\n</li>', 'hcisecurity.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `post_like`
--

CREATE TABLE `post_like` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `post_like`
--

INSERT INTO `post_like` (`id`, `user_id`, `post_id`) VALUES
(2, 1, 2),
(3, 1, 1),
(4, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(15) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL
) ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `email`, `password_hash`, `is_admin`) VALUES
(1, 'Theo', 'Theodor', 'Kozlowski', 'kozlowskitr@cardiff.ac.uk', 'pbkdf2:sha256:150000$2KtEj9ol$16048932a8ce7408ace571208b4fccb2a942407ccc69203ab579e93773d3781e', 1),
(2, 'MarkFisher', 'Mark', 'Fisher', 'allhailtotheale@gmail.com', 'pbkdf2:sha256:150000$9dcO7mbA$8b9036e87018aaac6cb21ec5ec049bbf337534792cdb74a8d0e145b9da56038a', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `likers`
--
ALTER TABLE `likers`
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `post_like`
--
ALTER TABLE `post_like`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `first_name` (`first_name`),
  ADD UNIQUE KEY `last_name` (`last_name`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `post_like`
--
ALTER TABLE `post_like`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `comment` (`id`),
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  ADD CONSTRAINT `comment_ibfk_3` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `likers`
--
ALTER TABLE `likers`
  ADD CONSTRAINT `likers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `post` (`id`);

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `post_like`
--
ALTER TABLE `post_like`
  ADD CONSTRAINT `post_like_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `post_like_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
