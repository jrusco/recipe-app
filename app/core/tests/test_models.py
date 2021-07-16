from django.test import TestCase
from django.contrib.auth import get_user_model

class ModelTests(TestCase):

    def test_create_user_with_email_successful(self):
        """
        test creating a new user with an email is successful
        """
        email = "some@email.com"
        password = "password123"
        user = get_user_model().objects.create_user(
            email=email,
            password=password
        )

        self.assertEqual(user.email, email)
        self.assertTrue(user.check_password(password))

    def test_new_user_email_normalized(self):
        """
        test the user's email is normalized
        """
        email = 'some@OTHEREMAIL.NET'
        user = get_user_model().objects.create_user(email, "pass")

        self.assertEqual(email.lower(), user.email)

    def test_new_user_invalid_email(self):
        """
        test creating an user with no email raises an error
        """
        with self.assertRaises(ValueError):
            get_user_model().objects.create_user(None, "pass")
