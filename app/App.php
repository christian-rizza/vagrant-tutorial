<?php

//require 'classes/ModuleInfo.php';
//require 'classes/FormatHelper.php';

require '../vendor/autoload.php';

class App
{
    /**
     * @return string
     */
    public static function getOutput()
    {

        error_reporting(E_ALL);
        ini_set('display_errors', 1);

        /** @var ModuleInfo $moduleInfo */
        $moduleInfo = new ModuleInfo();
        $module = null;

        if (!empty($_REQUEST["module"])) {
            $moduleName = filter_var(
                $_REQUEST["module"], FILTER_SANITIZE_STRING
            );

            $module = $moduleInfo->getModuleInfo($moduleName);
        }

        /** @var FormatHelper $formatHelper */
        $formatHelper = new FormatHelper();

        if ($module) {
            return $formatHelper->formatOutput($moduleInfo->getModuleInfo($moduleName));
        } else {
            return $formatHelper->formatOutput($moduleInfo->getModuleList());
        }
    }
}

?>