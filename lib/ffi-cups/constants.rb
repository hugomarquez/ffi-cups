module Cups
  # cups.h
  FORMAT_JPEG		        = "image/jpeg"
  FORMAT_PDF		        = "application/pdf"
  FORMAT_TEXT		        = "text/plain"
  JOBID_ALL             = -1
  WHICHJOBS_ALL         = -1
  WHICHJOBS_ACTIVE      = 0
  WHICHJOBS_COMPLETED   = 1
  HTTP_DEFAULT          = nil

  # Options and Values
  COPIES                = "copies"
  COPIES_SUPPORTED      = "copies-supported"
  
  FINISHINGS            = "CUPS_FINISHINGS"
  FINISHINGS_SUPPORTED  = "finishings-supported"
  FINISHINGS_BIND		    = "7"
  FINISHINGS_COVER		  = "6"
  FINISHINGS_FOLD		    = "10"
  FINISHINGS_NONE		    = "3"
  FINISHINGS_PUNCH		  = "5"
  FINISHINGS_STAPLE	    = "4"
  FINISHINGS_TRIM		    = "11"
  
  # MEDIA
  MEDIA			            = "media"
  MEDIA_READY		        = "media-ready"
  MEDIA_SUPPORTED		    = "media-supported"

  MEDIA_3X5		          = "na_index-3x5_3x5in"
  MEDIA_4X6	  	        = "na_index-4x6_4x6in"
  MEDIA_5X7		          = "na_5x7_5x7in"
  MEDIA_8X10		        = "na_govt-letter_8x10in"
  MEDIA_A3			        = "iso_a3_297x420mm"
  MEDIA_A4		          = "iso_a4_210x297mm"
  MEDIA_A5			        = "iso_a5_148x210mm"
  MEDIA_A6			        = "iso_a6_105x148mm"
  MEDIA_ENV10		        = "na_number-10_4.125x9.5in"
  MEDIA_ENVDL		        = "iso_dl_110x220mm"
  MEDIA_LEGAL	          = "na_legal_8.5x14in"
  MEDIA_LETTER		      = "na_letter_8.5x11in"
  MEDIA_PHOTO_L		      = "oe_photo-l_3.5x5in"
  MEDIA_SUPERBA3		    = "na_super-b_13x19in"
  MEDIA_TABLOID		      = "na_ledger_11x17in"

  MEDIA_SOURCE		        = "media-source"
  MEDIA_SOURCE_SUPPORTED	= "media-source-supported"

  MEDIA_SOURCE_AUTO	  = "auto"
  MEDIA_SOURCE_MANUAL	= "manual"

  MEDIA_TYPE		        = "media-type"
  MEDIA_TYPE_SUPPORTED	= "media-type-supported"

  MEDIA_TYPE_AUTO		      = "auto"
  MEDIA_TYPE_ENVELOPE	    = "envelope"
  MEDIA_TYPE_LABELS	      = "labels"
  MEDIA_TYPE_LETTERHEAD	  = "stationery-letterhead"
  MEDIA_TYPE_PHOTO		      = "photographic"
  MEDIA_TYPE_PHOTO_GLOSSY	= "photographic-glossy"
  MEDIA_TYPE_PHOTO_MATTE	  = "photographic-matte"
  MEDIA_TYPE_PLAIN		      = "stationery"
  MEDIA_TYPE_TRANSPARENCY	= "transparency"

  NUMBER_UP		        = "number-up"
  NUMBER_UP_SUPPORTED	= "number-up-supported"

  ORIENTATION		        = "orientation-requested"
  ORIENTATION_SUPPORTED	= "orientation-requested-supported"

  ORIENTATION_PORTRAIT	  = "3"
  ORIENTATION_LANDSCAPE	= "4"

  PRINT_COLOR_MODE		        = "print-color-mode"
  PRINT_COLOR_MODE_SUPPORTED = "print-color-mode-supported"

  PRINT_COLOR_MODE_AUTO	      = "auto"
  PRINT_COLOR_MODE_MONOCHROME  = "monochrome"
  PRINT_COLOR_MODE_COLOR	      = "color"

  PRINT_QUALITY		        = "print-quality"
  PRINT_QUALITY_SUPPORTED	= "print-quality-supported"

  PRINT_QUALITY_DRAFT	= "3"
  PRINT_QUALITY_NORMAL	= "4"
  PRINT_QUALITY_HIGH   = "5"

  SIDES			      = "sides"
  SIDES_SUPPORTED	=	"sides-supported"

  SIDES_ONE_SIDED		        = "one-sided"
  SIDES_TWO_SIDED_PORTRAIT	  = "two-sided-long-edge"
  SIDES_TWO_SIDED_LANDSCAPE  = "two-sided-short-edge"
end
