-- Heatmap database initial skeleton
--
-- Create `Conversation` table
-- Stores information about a single contact
--

CREATE TABLE `Conversation` (
  `conversation_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  `intensity` int(11) NOT NULL,
  `initiated` tinyint(1) DEFAULT '0',
  `nature` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Create `Employee` table
--

CREATE TABLE `Employee` (
  `employee_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Create `Employee_to_Response` table
--

CREATE TABLE `Employee_to_Response` (
  `employee_id` int(11) NOT NULL,
  `response_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Create `intensity` table
--

CREATE TABLE `intensity` (
  `intensity_id` int(11) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`intensity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Create `Nature` table
--

CREATE TABLE `Nature` (
  `nature_id` int(11) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`nature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Create `Response` table
--

CREATE TABLE `Response` (
  `response_is` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `conversation_id` int(11) NOT NULL,
  PRIMARY KEY (`response_is`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Create `Role` table
--

CREATE TABLE `Role` (
  `role_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Create `Unit` table
-- Stores names of various units (e.g. XFT1, XFT2, Department1 etc)
--

CREATE TABLE `Unit` (
  `unit_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
