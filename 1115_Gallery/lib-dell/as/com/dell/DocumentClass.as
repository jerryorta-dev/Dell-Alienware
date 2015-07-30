/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 4/30/13
 * Time: 12:52 PM
 *
 */
package com.dell {
import com.dpa.interactive.TopLevel;

import flash.display.StageAlign;
import flash.display.StageScaleMode;

import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.Security;
import flash.system.SecurityDomain;

public class DocumentClass extends TopLevel {




    public static var context:LoaderContext;

//    protected var urls:Vector.<Object> = new Vector.<Object>;

    public function DocumentClass() {
        super();

        Security.allowDomain( "*" );
        Security.allowInsecureDomain("*");
//        Security.allowDomain( "http://sandbox.gsdprototypes.com/" );
//        Security.allowDomain( "http://localhost:8080/GitHub/dell/1115-product-launch-aw-17-ranger-flash/1115-Code/out/production/1115-Shell/Main-1115-Video.html" );
//        Security.allowDomain( "http://player.ooyala.com/player.swf?version=2&embedType=flashplayer.as&" );




//        context = new LoaderContext( );
//        context.securityDomain = SecurityDomain.currentDomain;
//        context.checkPolicyFile = true;
//        if( Security.sandboxType == Security.REMOTE )
//        {
//            context.securityDomain = SecurityDomain.currentDomain;
//        }
//        context.applicationDomain = ApplicationDomain.currentDomain;

    }





}
}
