DROP DATABASE IF EXISTS docText;
CREATE DATABASE docText;
USE docText;

CREATE TABLE documents(
DocID INT AUTO_INCREMENT,
Doc TEXT,
FULLTEXT(Doc),
CONSTRAINT PK_doc PRIMARY KEY(DocID)
);

INSERT INTO documents (Doc) VALUES("The Ohio class of nuclear-powered submarines includes the United States Navy's 14 ballistic missile submarines (SSBNs) 
	and its four cruise missile submarines (SSGNs). Each displacing 18,750 tons submerged, the Ohio-class boats are the largest submarines ever built 
	for the U.S. Navy. They are the world's third-largest submarines, behind the Russian Navy's Soviet-designed 48,000-ton Typhoon class 
	and 24,000-ton Borei class.The Ohios carry more missiles than either: 24 Trident II missiles apiece, versus 16 by the Borei class
	(20 by the Borei II) and 20 by the Typhoon class. Like its predecessor Benjamin Franklin- and Lafayette-class subs,
	the Ohio SSBNs are part of the United States' nuclear-deterrent triad, along with U.S. Air Force strategic bombers and intercontinental 
	ballistic missiles.The 14 SSBNs together carry about half of U.S. active strategic thermonuclear warheads. 
	Although the Trident missiles have no preset targets when the submarines go on patrol, they can be given targets quickly, 
	from the United States Strategic Command based in Nebraska,using secure and constant radio communications links, including very low frequency systems.The 
	lead submarine of this class is USS Ohio. All the Ohio-class submarines, except for USS Henry M. Jackson, are named for U.S. states, 
	which U.S. Navy tradition had previously reserved for battleships and cruisers. The Ohio class is to be gradually replaced by the Columbia class 
	beginning in 2031.");

INSERT INTO documents (Doc) VALUES("The Los Angeles class of submarines are nuclear-powered fast attack submarines (SSN) in service with the United States Navy. 
	Also known as the 688 class (pronounced 'six-eighty-eight') after the hull number of lead vessel USS Los Angeles (SSN-688), 62 were built from 1972 to 
	1996, the latter 23 to an improved 688i standard. As of 2020, 32 of the Los Angeles class remain in commission — more than any other class in the world — 
	and they account for more than half of the U.S. Navy's 53 fast attack submarines. Of the 30 retired boats, a few were in commission for nearly 40 years, 
	including USS Dallas (SSN-700), USS Jacksonville (SSN-699) and USS Bremerton (SSN-698). With a wide variance in longevity, 12 of the 688s were 
	laid up halfway through their projected lifespans, USS Baltimore (SSN-704) being the youngest-retired at 15 years, 11 months.
	Another five also laid up early (20–25 years), due to their midlife reactor refueling being cancelled, and one was lost during overhaul due to arson. 
	Two have been converted to moored training ships, and all others are being scrapped per the Navy's Ship-Submarine Recycling Program. Submarines of this 
	class are named after American towns and cities, such as Albany, New York; Los Angeles, California; and Tucson, Arizona, with the exception of USS Hyman G. 
	Rickover, named for the 'father of the nuclear Navy.' This was a change from traditionally naming attack submarines after marine animals, 
	such as USS Seawolf or USS Shark.");

INSERT INTO documents (Doc) VALUES("The Virginia class, also known as the SSN-774 class, is a class of nuclear-powered cruise missile fast-attack submarines, 
	in service in the United States Navy. Designed by General Dynamics's Electric Boat (EB) and Huntington Ingalls Industries, the Virginia-class is the 
	United States Navy's latest submarine model, which incorporates the latest in stealth, intelligence gathering, and weapons systems technology. 
	Virginia-class submarines are designed for a broad spectrum of open-ocean and littoral missions, including anti-submarine warfare and intelligence 
	gathering operations. They are scheduled to replace older Los Angeles-class submarines, many of which have already been decommissioned. 
	Virginia-class submarines will be acquired through 2043, and are expected to remain in service until at least 2060, 
	with later submarines expected to remain into the 2070s.");

INSERT INTO documents (Doc) VALUES("The Seawolf design was intended to combat the threat of advanced Soviet ballistic missile submarines such as the 
	Typhoon class, and attack submarines such as the Akula class in a deep-ocean environment. Seawolf-class hulls are constructed from HY-100 steel, 
	which is stronger than the HY-80 steel employed in previous classes, in order to withstand water pressure at greater depths. 
	Seawolf submarines are larger, faster, and significantly quieter than previous Los Angeles-class submarines; they also carry more weapons and 
	have twice as many torpedo tubes. The boats are able to carry up to 50 UGM-109 Tomahawk cruise missiles for attacking land and sea surface targets. 
	The boats also have extensive equipment to allow shallow water operations. The class uses the more advanced ARCI Modified AN/BSY-2 combat system, 
	which includes a larger spherical sonar array, a wide aperture array (WAA), and a new towed-array sonar.[12] Each boat is powered by a single S6W 
	nuclear reactor, delivering 45,000 hp (34 MW) to a low-noise pump-jet. As a result of their advanced design, however, Seawolf submarines 
	were much more expensive. The projected cost for 12 submarines of this class was $33.6 billion, but construction was stopped at 
	three boats when the Cold War ended.");
