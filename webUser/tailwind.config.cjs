/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./app/**/*.{js,ts,jsx,tsx}", "./components/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        card: "hsl(var(--card))",
        cardForeground: "hsl(var(--card-foreground))",
        panel: "hsl(var(--panel))",
        elevated: "hsl(var(--elevated))",
        primary: "hsl(var(--primary))",
        primaryForeground: "hsl(var(--primary-foreground))",
        muted: "hsl(var(--muted))",
        mutedForeground: "hsl(var(--muted-foreground))",
        subtle: "hsl(var(--subtle))",
        subtleForeground: "hsl(var(--subtle-foreground))",
        border: "hsl(var(--border))",
        success: "hsl(var(--success))",
        successForeground: "hsl(var(--success-foreground))",
        warning: "hsl(var(--warning))",
        warningForeground: "hsl(var(--warning-foreground))",
        danger: "hsl(var(--danger))",
        dangerForeground: "hsl(var(--danger-foreground))",
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
    },
  },
  plugins: [],
};
