package com.kinderedu.backend.util;

public class Validator {
    public static boolean validarCpf(String cpf){
        try {
            // Cálculo do primeiro dígito verificador
            int sum = 0;
            for (int i = 0; i < 9; i++) {
                sum += (cpf.charAt(i) - '0') * (10 - i);
            }
            int firstDigit = 11 - (sum % 11);
            if (firstDigit > 9) firstDigit = 0;

            // Cálculo do segundo dígito verificador
            sum = 0;
            for (int i = 0; i < 10; i++) {
                sum += (cpf.charAt(i) - '0') * (11 - i);
            }
            int secondDigit = 11 - (sum % 11);
            if (secondDigit > 9) secondDigit = 0;

            return (cpf.charAt(9) - '0' == firstDigit) &&
                    (cpf.charAt(10) - '0' == secondDigit);

        } catch (Exception e) {
            return false;
        }
    }
}
