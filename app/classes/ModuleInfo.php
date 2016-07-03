<?php

class ModuleInfo
{
    /** @var FormatHelper $formatHelper */
    private $formatHelper;

    /**
     * ModuleInfo constructor.
     */
    public function __construct()
    {
        $this->formatHelper = new FormatHelper();
    }

    /**
     * Get the module info
     *
     * @param $moduleName
     *
     * @return array
     */
    public function getModuleInfo($moduleName)
    {
        if (extension_loaded($moduleName)) {
            return $this->formatHelper->getFormatedData(
                get_extension_funcs($moduleName), true, $moduleName
            );
        } else {
            return $this->formatHelper->getFormatedData(
                "Module not found", false
            );
        }
    }

    /**
     * @return array
     */
    public function getModuleList()
    {
        $moduleList = array();
        $modules = get_loaded_extensions();

        foreach ($modules as $module) {
            $moduleInfo = $this->getModuleInfo($module);
            if ($moduleInfo['info']) {
                $moduleList[$moduleInfo['info']]
                    = '<a href="http://tutorial.crizza.dev/?module='
                    . $moduleInfo['info'] . '">link</a>';
            }
        }


        return $this->formatHelper->getFormatedData(
            $moduleList, true
        );
    }
}
