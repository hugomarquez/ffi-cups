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
- Connection to not be a singleton class
- Cancel jobs

## Example usage
```ruby
require 'ffi-cups'

printers = Cups::Printer.get_destinations
# [#<Cups::Printer:0x000055fe50b15798 @name="Virtual_PDF_Printer",
#  @options={"copies"=>"1", "device-uri"=>"cups-pdf:/", "finishings"=>"3" 
#  "job-cancel-after"=>"10800", "job-hold-until"=>"no-hold", ...

printer = Cups::Printer.get_destination("Virtual_PDF_Printer")
# <Cups::Printer:0x0000560f1d4e0958 @name="Virtual_PDF_Printer", @options={"copies"=>"1" 
#   "device-uri"=>"cups-pdf:/", ...

printer.state
# :idle 

printer.state_reasons
# ["none"]

# Print a file (PDF, JPG, etc) you can pass a hash of printing options if you
# want to override the printer's default. See Cups::Constants for more options
options = {
  Cups::CUPS_MEDIA => Cups::CUPS_MEDIA_A4,
  Cups::CUPS_ORIENTATION => Cups::CUPS_ORIENTATION_LANDSCAPE
}

job = printer.print_file('/tmp/example.jpg', 'Title', options)
# <Cups::Job:0x000055c87104d1e0 @id=10, @title="README", @printer="Virtual_PDF_Printer", @format="text/plain", @state=:processing, @size=4, @completed_time=1969-12-31 18:00:00 -0600, @creation_time=2021-04-18 17:35:04 -0500, @processing_time=2021-04-18 17:35:04 -0500> 

# Get all jobs from a printer
jobs = Cups::Job.get_jobs('Virtual_PDF_Printer')
# [#<Cups::Job:0x0000563aa6359008 @id=1, @title="Test Print", @printer="Virtual_PDF_Printer", @format="text/plain", @state=:completed, @size=1, @completed_time=2021-04-08 07:06:23 -0500, @creation_time=2021-04-08 07:06:18 -0500, @processing_time=2021-04-08 07:06:18 -0500>, ...]

# filtering job's query, see Constants file for more options
jobs = Cups::Job.get_jobs('Virtual_PDF_Printer', Cups::CUPS_WHICHJOBS_ACTIVE)

# Query job with id and printer's name
job = Cups::Job.get_job(10, 'Virtual_PDF_Printer')
# <Cups::Job:0x000055c870fc8490 @id=10, @title="README", @printer="Virtual_PDF_Printer", @format="text/plain", @state=:completed, @size=4, @completed_time=2021-04-18 17:35:04 -0500, @creation_time=2021-04-18 17:35:04 -0500, @processing_time=2021-04-18 17:35:04 -0500>

```

## Remote CUPS Server
You may create a connection object passing a :hostname and/or :port arguments.

```ruby
# Create a Connection object with hostname and/or port
connection = Cups::Connection.instance('print.example.com')

# Get all printers from the remote connection
remote_printers = Cups::Printer.get_destinations(connection)

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
