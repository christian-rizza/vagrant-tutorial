<?php


class FormatHelper
{
    const SUCCESS = "success";
    const FAIL = "failed";

    /**
     * @param $output
     *
     * @return string
     */
    public static function formatOutput($output)
    {
        $result = '<pre style="text-align: left" >';
        $result .= print_r($output, true);
        $result .= "</pre>";

        return $result;
    }

    /**
     * @param      $data
     * @param      $success
     * @param null $info
     *
     * @return array
     */
    public function getFormatedData($data, $success, $info = null)
    {
        $result = array();

        if ($success) {
            if ($info) {
                $result["info"] = $info;
            }
            $result["status"] = self::SUCCESS;
            $result["data"] = $data;
        }
        else
        {
            $result["status"] = self::FAIL;
            $result["data"] = $data;
        }

        return $result;
    }
}
