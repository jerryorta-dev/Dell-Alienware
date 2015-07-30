/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/6/13
 * Time: 3:44 PM
 *
 */
package com.dpa.loading.core {
import com.dpa.utils.fileNames.FileType;
import com.dpa.utils.fileNames.getExtension;
import com.greensock.loading.BinaryDataLoader;
import com.greensock.loading.CSSLoader;
import com.greensock.loading.DataLoader;
import com.greensock.loading.ImageLoader;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.MP3Loader;
import com.greensock.loading.SWFLoader;
import com.greensock.loading.VideoLoader;
import com.greensock.loading.XMLLoader;
import com.greensock.loading.core.LoaderCore;

public class LoaderUtils {

    //reference classes if needed.
    public static const BINARY_DATA_LOADER:String = "com.greensock.loading.BinaryDataLoader";
    public static const CSS_LOADER:String = "com.greensock.loading.CSSLoader";
    public static const DATA_LOADER:String = "com.greensock.loading.DataLoader";
    public static const IMAGE_LOADER:String = "com.greensock.loading.ImageLoader";
    public static const MP3_LOADER:String = "com.greensock.loading.MP3Loader";
    public static const SELF_LOADER:String = "com.greensock.loading.SelfLoader";
    public static const SWF_LOADER:String = "com.greensock.loading.SWFLoader";
    public static const VIDEO_LOADER:String = "com.greensock.loading.VideoLoader";
    public static const XML_LOADER:String = "com.greensock.loading.XMLLoader";



    public static function createLoader(_path:String, _params:Object, _fileType:String = null):LoaderCore {

        if (FileType.isBinary(_path, _fileType)) {
            LoaderMax.activate([BinaryDataLoader]);
            return new BinaryDataLoader(_path, _params);
        }

        if (FileType.isCSS(_path, _fileType)) {
            LoaderMax.activate([CSSLoader]);
            return new CSSLoader(_path, _params);
        }

        if (FileType.isData(_path, _fileType)) {
            LoaderMax.activate([DataLoader]);
            return new DataLoader(_path, _params);
        }

        if (FileType.isImage(_path, _fileType)) {
            LoaderMax.activate([ImageLoader]);
            return new ImageLoader(_path, _params);
        }

        if (FileType.isMP3(_path, _fileType)) {
            LoaderMax.activate([MP3Loader]);
            return new MP3Loader(_path, _params);
        }

        if (FileType.isSwf(_path, _fileType)) {
            LoaderMax.activate([SWFLoader]);
            return new SWFLoader(_path, _params);
        }

        if (FileType.isVideo(_path, _fileType)) {
            LoaderMax.activate([VideoLoader]);
            return new VideoLoader(_path, _params);
        }

        return new XMLLoader(_path, _params);

    }
}
}
