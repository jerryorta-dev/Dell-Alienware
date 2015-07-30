/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 5/5/13
 * Time: 8:57 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.fileNames {
    import com.adobe.air.logging.FileTarget;

    /**
     * Type of file based on extension
     */
    public class FileType {

        //Data
        public static const JSON:String = "json";

        public static const XML:String = "xml";

        //Binary
        public static const TXT:String = "txt";
        public static const ZIP:String = "zip";

        //Image
        public static const JPG:String = "jpg";
        public static const PNG:String = "png";
        public static const GIF:String = "gif";

        //Sound
        public static const MP3:String = "mp3";

        //Video
        public static const FLV:String = "flv";
        public static const MOV:String = "mov";
        public static const MP4:String = "mp4";

        //SWF
        public static const SWF:String = "swf";

        //CSS
        public static const CSS:String = "css";



        public static function isFileType(_filePath:String, fileType:String):Boolean {
            if (getExtension(_filePath) === fileType) {
                return true;
            } else {
                return false;
            }
        }



        public static function isData(filePath:String, fileType:String = null):Boolean {
            var _extension:String = getExtension(filePath);

            if (_extension !== fileType) {
                return false;
            }

            if (_extension === FileType.JSON) {
                return true;
            } else {
                return false;
            }
        }



        public static function isXML(filePath:String, fileType:String = null):Boolean {
            var _extension:String = getExtension(filePath);

            if (_extension !== fileType) {
                return false;
            }

            if (_extension === FileType.XML) {
                return true;
            } else {
                return false;
            }
        }

        public static function isImage(filePath:String, fileType:String = null):Boolean {
            var _extension:String = getExtension(filePath);

            if (_extension !== fileType) {
                return false;
            }

            if (_extension === FileType.JPG || _extension === FileType.PNG || _extension === FileType.GIF) {
                return true;
            } else {
                return false;
            }
        }

        public static function isMP3(filePath:String, fileType:String = null):Boolean {
            var _extension:String = getExtension(filePath);

            if (_extension !== fileType) {
                return false;
            }

            if (_extension === FileType.MP3) {
                return true;
            } else {
                return false;
            }
        }

        public static function isVideo(filePath:String, fileType:String = null):Boolean {
            var _extension:String = getExtension(filePath);

            if (_extension !== fileType) {
                return false;
            }

            if (_extension === FileType.FLV || _extension === FileType.MOV || _extension === FileType.MP4) {
                return true;
            } else {
                return false;
            }
        }

        public static function isSwf(filePath:String, fileType:String = null):Boolean {
            var _extension:String = getExtension(filePath);

            if (_extension !== fileType) {
                return false;
            }

            if (_extension === FileType.SWF) {
                return true;
            } else {
                return false;
            }
        }

        public static function isCSS(filePath:String, fileType:String = null):Boolean {
            var _extension:String = getExtension(filePath);

            if (_extension !== fileType) {
                return false;
            }

            if (_extension === FileType.CSS) {
                return true;
            } else {
                return false;
            }
        }

        public static function isBinary(filePath:String, fileType:String = null):Boolean {
            var _extension:String = getExtension(filePath);

            if (_extension !== fileType) {
                return false;
            }

            if (_extension === FileType.TXT || _extension === FileType.ZIP) {
                return true;
            } else {
                return false;
            }
        }


    }
}
