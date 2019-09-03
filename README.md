# postfix-parser
Perl Postfix Parser

Based on: https://github.com/SvenAn/MailLogParser

Postfix-parser is a small ad-hoc script created to parse Postfix maillog files into a csv format where each line represents a single mail message. This script was heavily based upon MailLogParser by SvenAn, re-written in such a way as to strip back the functionality to focus entirely on a specific implementation of Postfix.

This script is not intended to be generalisable to other maillog variants; it was written as part of an MSc dissertation for the detection of compromised email accounts from maillog data.
