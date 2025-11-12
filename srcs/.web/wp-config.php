<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wpuser' );

/** Database password */
define( 'DB_PASSWORD', 'password' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '97}-:c@}:#SG}{=ohV:f#6$m.;OhYG8UFXs9[1NA@]R~T(]ns8@j>0:2w5@herdm' );
define( 'SECURE_AUTH_KEY',   'VH M~5D]+~.H#QEEoTlHOzt4@d2GY(]6O;zx{Pn)}}uv~#.?-_A#OW9o?;W-kkDH' );
define( 'LOGGED_IN_KEY',     'bU:M`_KHiN!@c9dS(sR F_0GD;<QHL<+>Q*M>>K0_=`-KeUOV-b`Hdh*2|bSx%Q@' );
define( 'NONCE_KEY',         'T-W$NY]d}0H5.RBPdXrg6|h`^]qm*Xvc/L-WIj_h4+ojyC`gM?:,g+a9}R/o5s3A' );
define( 'AUTH_SALT',         '+73&jDq]iq.pn(cD/?,.[)IfaHg4flrVt(C|Y!?D Gz3={69M.Vol-|shnTm>0uE' );
define( 'SECURE_AUTH_SALT',  'Lc(Tm~9;uN$?Dna~rYT^7[?AMb05:[8DfG[PQ72/5gMYd&+Tei<[vO_=xb2DPcHw' );
define( 'LOGGED_IN_SALT',    '.UlhzI7SahqMi)leAEYRf_dZZGj;:yxD.ivq7i-)EghH~#zTKM1fK<GL8lWF!L)p' );
define( 'NONCE_SALT',        'W{dY!tq4KQ.UxrTKWrP*#BpTt*LlZLn*9}VJG~Su5wNU`C=[TPH|`Gas,nKld:4U' );
define( 'WP_CACHE_KEY_SALT', '4_u}kx !o>)=~E5]0M7&~2F7iu(x%;3vZQrEP:C0ADv![G}({9DToi0%XI~8j+s!' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
