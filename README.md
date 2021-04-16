# ffi-cups
[![Gem Version](https://badge.fury.io/rb/ffi-cups.svg)](https://badge.fury.io/rb/ffi-cups)

ffi-cups is a FFI wrapper around libcups providing access to the Cups API.
It was written using Ruby 2.7.0.

## About
This is a complete rewrite of the cupsffi gem, it will deprecate
functions deprecated by the CUPS API, if you wish to continue to use them,
use the cupsffi gem.

## Authors
- Hugo Marquez @ www.hugomarquez.mx
- Contributors @ https://github.com/hugomarquez/ffi-cups/graphs/contributors

## Installation
```bash
gem install ffi-cups
```

## Setup
ffi-cups requires libcups2 to be installed

## TODO
- send print jobs by creating the job itself first.

## Example usage
```ruby
require 'ffi-cups'

printers = Cups::Printer.get_destinations
# [#<Cups::Printer:0x000055fe50b178e0 @name="HP_Officejet_J4500_series_ubuntu", @options={"device-uri"=>"ipps://HP%20Officejet%20J4500%20series%20%40%20ubuntu._ipps._tcp.local/cups", "printer-info"=>"HP Officejet J4500 series @ ubuntu", "printer-location"=>"", "printer-make-and-model"=>"HP Officejet j4585 All-in-one Printer", "printer-type"=>"16814110"}>, #<Cups::Printer:0x000055fe50b15798 @name="Virtual_PDF_Printer", @options={"copies"=>"1", "device-uri"=>"cups-pdf:/", "finishings"=>"3", "job-cancel-after"=>"10800", "job-hold-until"=>"no-hold", "job-priority"=>"50", "job-sheets"=>"none,none", "marker-change-time"=>"0", "number-up"=>"1", "printer-commands"=>"AutoConfigure,Clean,PrintSelfTestPage", "printer-info"=>"Virtual PDF Printer", "printer-is-accepting-jobs"=>"true", "printer-is-shared"=>"false", "printer-is-temporary"=>"false", "printer-location"=>"", "printer-make-and-model"=>"Generic CUPS-PDF Printer (w/ options)", "printer-state"=>"3", "printer-state-change-time"=>"1617884232", "printer-state-reasons"=>"none", "printer-type"=>"10547276", "printer-uri-supported"=>"ipp://localhost/printers/Virtual_PDF_Printer"}>]

printer = Cups::Printer.get_destination("Virtual_PDF_Printer")
#<Cups::Printer:0x0000560f1d4e0958 @name="Virtual_PDF_Printer", @options={"copies"=>"1", "device-uri"=>"cups-pdf:/", "finishings"=>"3", "job-cancel-after"=>"10800", "job-hold-until"=>"no-hold", "job-priority"=>"50", "job-sheets"=>"none,none", "marker-change-time"=>"0", "number-up"=>"1", "printer-commands"=>"AutoConfigure,Clean,PrintSelfTestPage", "printer-info"=>"Virtual PDF Printer", "printer-is-accepting-jobs"=>"true", "printer-is-shared"=>"false", "printer-is-temporary"=>"false", "printer-location"=>"", "printer-make-and-model"=>"Generic CUPS-PDF Printer (w/ options)", "printer-state"=>"3", "printer-state-change-time"=>"1617884232", "printer-state-reasons"=>"none", "printer-type"=>"10547276", "printer-uri-supported"=>"ipp://localhost/printers/Virtual_PDF_Printer"}> 

```

## Remote CUPS Server
You may create a connection object passing a :hostname and/or :port arguments.

You are in charge of the connection object, remember to close the 
connection once you stop using it.

```ruby
# Create a Connection object with hostname and/or port
connection = Cups::Connection.instance(hostname:'print.example.com')

# Create a http pointer with CUPS API
http = connection.httpConnect2

# Get all printers from the remote connection
remote_printers = Cups::Printer.get_destinations(http)

# Close connection and release pointer
Cups::Connection.close(http)
```

## License
The MIT License

Copyright (c) 2021 Hugo Marquez & Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
