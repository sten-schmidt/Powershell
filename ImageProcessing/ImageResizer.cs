using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;

namespace ImageResize
{
    public class ImageResizer : IDisposable
    {
        private Image _srcImage;

        public string SourceImagePath { get; private set; }
        public int SourceWidth { get; private set; }
        public int SourceHeight { get; private set; }

        public string DestinationImagePath { get; private set; }
        public int DestinationWidth { get; private set; }
        public int DestinationHeight { get; private set; }

        public int CalcWidth { get; private set; }
        public int CalcHeight { get; private set; }

        public decimal AspectRatio { get; private set; }

        public ImageResizer(string sourceImagePath, string destinationImagePath, int destinationHeight, int destinationWidth)
        {
            SourceImagePath = sourceImagePath;
            DestinationImagePath = destinationImagePath;
            DestinationHeight = destinationHeight;
            DestinationWidth = destinationWidth;
            _srcImage = Image.FromFile(SourceImagePath);
            calc();
        }

        private void calc()
        {
            SourceHeight = _srcImage.Height;
            SourceWidth = _srcImage.Width;

            AspectRatio = SourceWidth / (Decimal)SourceHeight;

            if (_srcImage.Width > _srcImage.Height)
            {
                CalcHeight = Decimal.ToInt32(DestinationWidth / AspectRatio);
                CalcWidth = DestinationWidth;

                if (CalcHeight > DestinationHeight)
                {
                    CalcWidth = Decimal.ToInt32(DestinationHeight * AspectRatio);
                    CalcHeight = DestinationHeight;
                }
            }
            else
            {
                CalcWidth = Decimal.ToInt32(DestinationHeight * AspectRatio);
                CalcHeight = DestinationHeight;

                if (CalcWidth > DestinationWidth)
                {
                    CalcHeight = Decimal.ToInt32(DestinationWidth / AspectRatio);
                    CalcWidth = DestinationWidth;
                }
            }
        }

        public bool Resize()
        {
            bool result = false;
                        
            using (Bitmap newImage = new Bitmap(CalcWidth, CalcHeight))
            {
                using (Graphics gr = Graphics.FromImage(newImage))
                {
                    gr.SmoothingMode = SmoothingMode.HighQuality;
                    gr.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    gr.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    gr.DrawImage(_srcImage, new Rectangle(0, 0, CalcWidth, CalcHeight));
                }
                    
                newImage.Save(DestinationImagePath, _srcImage.RawFormat);
                result = File.Exists(DestinationImagePath);
            }
            
            return result;
        }

        public void Dispose()
        {
            if (_srcImage != null) _srcImage.Dispose();
            _srcImage = null;
        }
    }
}
