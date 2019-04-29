<?php

trait LogInAs
{
    /**
     * @Given I log in as behat user
     */
    public function logInAsBehat()
    {
        $user = 'cloudappsteam+behat@gmail.com';
        $pass = env('BEHAT_PASSWORD');

        $this->loginForm($user, $pass);
    }

    /**
     * @Given I log in as admin
     */
    public function logInAsAdmin()
    {
        $user = 'cloudappsteam+opensight@gmail.com';
        $pass = env('ADMIN_PASSWORD');

        $this->loginForm($user, $pass);
    }

    /**
     * @Given I log in as isle
     */
    public function logInAsIsle()
    {
        $user = 'isle';
        $pass = 'isle'; # env('ADMIN_PASSWORD');

        $this->loginForm($user, $pass);
    }

    public function loginForm($user, $pass)
    {
        /**
         * if for any reason we are logged in still
         */
        $this->visit('/logout');
        sleep(1);
        $this->visit('/login');
        sleep(2);
        $this->fillField('email', $user);
        $this->fillField('password', $pass);
        $this->pressButton('Login');
        sleep(1);
    }
}
