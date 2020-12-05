// See the Tailwind default theme values here:
// https://github.com/tailwindcss/tailwindcss/blob/master/stubs/defaultConfig.stub.js

module.exports = {
  plugins: [
    // Uncomment the following if you'd like to use TailwindUI
    require('@tailwindcss/ui'),
    require('@tailwindcss/forms')
  ],

  // All the default values will be compiled unless they are overridden below
  theme: {
    extend: {
      // Extend (add to) the default theme in the `extend` key
      maxWidth: {
        '1/2': '50%',
        '1/3': '33.333333%',
        '2/3': '66.666667%',
        '1/4': '25%',
        '2/4': '50%',
        '3/4': '75%',
        '1/5': '20%',
        '2/5': '40%',
        '3/5': '60%',
        '4/5': '80%',
        '1/6': '16.666667%',
        '2/6': '33.333333%',
        '3/6': '50%',
        '4/6': '66.666667%',
        '5/6': '83.333333%',
        '1/12': '8.333333%',
        '2/12': '16.666667%',
        '3/12': '25%',
        '4/12': '33.333333%',
        '5/12': '41.666667%',
        '6/12': '50%',
        '7/12': '58.333333%',
        '8/12': '66.666667%',
        '9/12': '75%',
        '10/12': '83.333333%',
        '11/12': '91.666667%',
      },
      screens: {
        'm-xl': {'max': '1279px'},
        // => @media (max-width: 1279px) { ... }

        'm-lg': {'max': '1023px'},
        // => @media (max-width: 1023px) { ... }

        'm-md': {'max': '767px'},
        // => @media (max-width: 767px) { ... }

        'm-sm': {'max': '639px'},
        // => @media (max-width: 639px) { ... }
        sm: '640px',
        md: '768px',
        lg: '1024px',
        xl: '1280px',
      },
      colors: {
        "primary-200": "#eef1ff",
        "primary-500": "#4965f6",
        "primary-600": "#1231d0",
        "secondary-200": "#e3f6ed",
        "secondary-500": "#3ecf8e",
        "secondary-600": "#36b47c",
        "tertiary-200": "#eeeeee",
        "tertiary-500": "#57586e",
        "tertiary-600": "#3a3b48",
        "danger-200": "#fff3f3",
        "danger-500": "#F37B7B",
        "danger-600": "#d26969",
        "code-400": "#fefcf9",
        "code-600": "#3c455b",
      },
      spacing: {
        '1/2': '50%',
        '1/3': '33.333333%',
        '2/3': '66.666667%',
        '1/4': '25%',
        '2/4': '50%',
        '3/4': '75%',
        '1/5': '20%',
        '2/5': '40%',
        '3/5': '60%',
        '4/5': '80%',
        '1/6': '16.666667%',
        '2/6': '33.333333%',
        '3/6': '50%',
        '4/6': '66.666667%',
        '5/6': '83.333333%',
        '1/12': '8.333333%',
        '2/12': '16.666667%',
        '3/12': '25%',
        '4/12': '33.333333%',
        '5/12': '41.666667%',
        '6/12': '50%',
        '7/12': '58.333333%',
        '8/12': '66.666667%',
        '9/12': '75%',
        '10/12': '83.333333%',
        '11/12': '91.666667%',
      },
    },
    
    // override the default theme using the key directly
    fontFamily: {
      sans: [
        "Lato",
        "-apple-system",
        "BlinkMacSystemFont",
        '"Segoe UI"',
        "Roboto",
        '"Helvetica Neue"',
        "Arial",
        '"Noto Sans"',
        "sans-serif",
        '"Apple Color Emoji"',
        '"Segoe UI Emoji"',
        '"Segoe UI Symbol"',
        '"Noto Color Emoji"',
      ],
    },
  },
}
