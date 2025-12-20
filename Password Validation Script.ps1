
# EXERCISE 1: PASSWORD STRENGTH VALIDATOR
# This script prompts the user to enter a password and validates it against
# security criteria. It provides visual feedback using colored text.

# Display a welcome message to the user
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   PASSWORD STRENGTH VALIDATOR" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Prompt the user to enter a password securely
# Note: Read-Host with -AsSecureString would hide the password, but for validation
# feedback purposes, we use regular Read-Host so the user can see what they type
Write-Host "Please enter a password to validate:" -ForegroundColor Yellow
$password = Read-Host

# Display the validation criteria to the user
Write-Host "`nValidating against the following criteria:" -ForegroundColor Cyan
Write-Host "  At least 8 characters" -ForegroundColor Gray
Write-Host "  At least one lowercase letter (a-z)" -ForegroundColor Gray
Write-Host "  At least one uppercase letter (A-Z)" -ForegroundColor Gray
Write-Host "  At least one special character (! | » / $ % ? & * ( ) _ + < > [ ] ^ { })" -ForegroundColor Gray
Write-Host ""


# VALIDATION LOGIC - Each criterion is checked individually

# CRITERION 1: Check if password has at least 8 characters
# The .Length property returns the number of characters in the string
$hasMinLength = $password.Length -ge 8

# CRITERION 2: Check if password contains at least one lowercase letter
# -cmatch is case-sensitive match operator
# [a-z] is a regular expression pattern that matches any lowercase letter
$hasLowercase = $password -cmatch "[a-z]"

# CRITERION 3: Check if password contains at least one uppercase letter
# [A-Z] matches any uppercase letter
$hasUppercase = $password -cmatch "[A-Z]"

# CRITERION 4: Check if password contains at least one special character
# The pattern matches any character from the specified special character set
# Characters like $ and ^ need to be escaped with backslash (\) because they
# have special meaning in regular expressions
$hasSpecialChar = $password -match "[!|»/$%?&*()\-_+<>\[\]^{}]"

# DETERMINE IF PASSWORD IS VALID

# The password is valid ONLY if ALL four criteria are met
# The -and operator requires all conditions to be true
$isValid = $hasMinLength -and $hasLowercase -and $hasUppercase -and $hasSpecialChar

# DISPLAY DETAILED FEEDBACK TO THE USER

Write-Host "Validation Results:" -ForegroundColor Cyan
Write-Host "-------------------" -ForegroundColor Cyan

# Show the status of each criterion with color coding
# Green checkmark (✓) for passed criteria, Red X (✗) for failed criteria
if ($hasMinLength) {
    Write-Host "  Minimum 8 characters: PASSED" -ForegroundColor Green
} else {
    Write-Host "  Minimum 8 characters: FAILED (Current: $($password.Length) characters)" -ForegroundColor Red
}

if ($hasLowercase) {
    Write-Host "  Lowercase letter: PASSED" -ForegroundColor Green
} else {
    Write-Host "  Lowercase letter: FAILED" -ForegroundColor Red
}

if ($hasUppercase) {
    Write-Host "  Uppercase letter: PASSED" -ForegroundColor Green
} else {
    Write-Host "  Uppercase letter: FAILED" -ForegroundColor Red
}

if ($hasSpecialChar) {
    Write-Host "  Special character: PASSED" -ForegroundColor Green
} else {
    Write-Host "  Special character: FAILED" -ForegroundColor Red
}

Write-Host ""

# ============================================================================
# DISPLAY FINAL VERDICT
# ============================================================================

# Display the final result with appropriate color
if ($isValid) {
    # All criteria met - display success message in GREEN
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "         STRONG PASSWORD" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "✓ Your password meets all security requirements!" -ForegroundColor Green
} else {
    # One or more criteria failed - display failure message in RED
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "          WEAK PASSWORD" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "✗ Your password does not meet the security requirements." -ForegroundColor Red
    Write-Host "  Please create a stronger password." -ForegroundColor Red
}

Write-Host ""
