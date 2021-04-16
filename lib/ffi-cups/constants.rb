module Cups
  # cups.h
  CUPS_FORMAT_JPEG		      = "image/jpeg"
  CUPS_FORMAT_PDF		        = "application/pdf"
  CUPS_FORMAT_TEXT		      = "text/plain"
  CUPS_JOBID_ALL            = -1
  CUPS_WHICHJOBS_ALL        = -1
  CUPS_WHICHJOBS_ACTIVE     = 0
  CUPS_WHICHJOBS_COMPLETED  = 1
  CUPS_HTTP_DEFAULT         = nil

  # Options and Values
  CUPS_COPIES               = "copies"
  CUPS_COPIES_SUPPORTED     = "copies-supported"

  CUPS_FINISHINGS           = "CUPS_FINISHINGS"
  CUPS_FINISHINGS_SUPPORTED = "finishings-supported"

  CUPS_FINISHINGS_BIND		  = "7"
  CUPS_FINISHINGS_COVER		  = "6"
  CUPS_FINISHINGS_FOLD		  = "10"
  CUPS_FINISHINGS_NONE		  = "3"
  CUPS_FINISHINGS_PUNCH		  = "5"
  CUPS_FINISHINGS_STAPLE	  = "4"
  CUPS_FINISHINGS_TRIM		  = "11"
  
  CUPS_MEDIA			          = "media"
  CUPS_MEDIA_READY		      = "media-ready"
  CUPS_MEDIA_SUPPORTED		  = "media-supported"

  CUPS_MEDIA_3X5		        = "na_index-3x5_3x5in"
  CUPS_MEDIA_4X6	  	      = "na_index-4x6_4x6in"
  CUPS_MEDIA_5X7		        = "na_5x7_5x7in"
  CUPS_MEDIA_8X10		        = "na_govt-letter_8x10in"
  CUPS_MEDIA_A3			        = "iso_a3_297x420mm"
  CUPS_MEDIA_A4		          = "iso_a4_210x297mm"
  CUPS_MEDIA_A5			        = "iso_a5_148x210mm"
  CUPS_MEDIA_A6			        = "iso_a6_105x148mm"
  CUPS_MEDIA_ENV10		      = "na_number-10_4.125x9.5in"
  CUPS_MEDIA_ENVDL		      = "iso_dl_110x220mm"
  CUPS_MEDIA_LEGAL	        = "na_legal_8.5x14in"
  CUPS_MEDIA_LETTER		      = "na_letter_8.5x11in"
  CUPS_MEDIA_PHOTO_L		    = "oe_photo-l_3.5x5in"
  CUPS_MEDIA_SUPERBA3		    = "na_super-b_13x19in"
  CUPS_MEDIA_TABLOID		    = "na_ledger_11x17in"

  CUPS_MEDIA_SOURCE		        = "media-source"
  CUPS_MEDIA_SOURCE_SUPPORTED	= "media-source-supported"

  CUPS_MEDIA_SOURCE_AUTO	  = "auto"
  CUPS_MEDIA_SOURCE_MANUAL	= "manual"

  CUPS_MEDIA_TYPE		        = "media-type"
  CUPS_MEDIA_TYPE_SUPPORTED	= "media-type-supported"

  CUPS_MEDIA_TYPE_AUTO		      = "auto"
  CUPS_MEDIA_TYPE_ENVELOPE	    = "envelope"
  CUPS_MEDIA_TYPE_LABELS	      = "labels"
  CUPS_MEDIA_TYPE_LETTERHEAD	  = "stationery-letterhead"
  CUPS_MEDIA_TYPE_PHOTO		      = "photographic"
  CUPS_MEDIA_TYPE_PHOTO_GLOSSY	= "photographic-glossy"
  CUPS_MEDIA_TYPE_PHOTO_MATTE	  = "photographic-matte"
  CUPS_MEDIA_TYPE_PLAIN		      = "stationery"
  CUPS_MEDIA_TYPE_TRANSPARENCY	= "transparency"

  CUPS_NUMBER_UP		        = "number-up"
  CUPS_NUMBER_UP_SUPPORTED	= "number-up-supported"

  CUPS_ORIENTATION		        = "orientation-requested"
  CUPS_ORIENTATION_SUPPORTED	= "orientation-requested-supported"

  CUPS_ORIENTATION_PORTRAIT	  = "3"
  CUPS_ORIENTATION_LANDSCAPE	= "4"

  CUPS_PRINT_COLOR_MODE		        = "print-color-mode"
  CUPS_PRINT_COLOR_MODE_SUPPORTED = "print-color-mode-supported"

  CUPS_PRINT_COLOR_MODE_AUTO	      = "auto"
  CUPS_PRINT_COLOR_MODE_MONOCHROME  = "monochrome"
  CUPS_PRINT_COLOR_MODE_COLOR	      = "color"

  CUPS_PRINT_QUALITY		        = "print-quality"
  CUPS_PRINT_QUALITY_SUPPORTED	= "print-quality-supported"

  CUPS_PRINT_QUALITY_DRAFT	= "3"
  CUPS_PRINT_QUALITY_NORMAL	= "4"
  CUPS_PRINT_QUALITY_HIGH   = "5"

  CUPS_SIDES			      = "sides"
  CUPS_SIDES_SUPPORTED	=	"sides-supported"

  CUPS_SIDES_ONE_SIDED		        = "one-sided"
  CUPS_SIDES_TWO_SIDED_PORTRAIT	  = "two-sided-long-edge"
  CUPS_SIDES_TWO_SIDED_LANDSCAPE  = "two-sided-short-edge"
end
