<?php
    function getYouTubeVideoId($pageVideUrl) {
        $link = $pageVideUrl;
        $video_id = explode("?v=", $link);
        if (!isset($video_id[1])) {
            $video_id = explode("youtu.be/", $link);
        }
        $youtubeID = $video_id[1];
        if (empty($video_id[1])) $video_id = explode("/v/", $link);
        $video_id = explode("&", $video_id[1]);
        $youtubeVideoID = $video_id[0];
        if ($youtubeVideoID) {
            return $youtubeVideoID;
        } else {
            return false;
        }
    }
    
    
    //Gera Hash MD5
    function newMD5Hash() {
        $hash = md5( date( 'dmYGis' ) );
        return $hash;
    }
?>
