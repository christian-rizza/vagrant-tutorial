<?php

namespace App\Libraries;

class Calculator
{
    public function add($x, $y)
    {
        if (!is_numeric($x) or !is_numeric($y)) {
            throw new \InvalidArgumentException;
        }

        return $x + $y;
    }
}
