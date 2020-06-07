# Bemer Simple Form

Using conventions from the `BEM` methodology in `SimpleForm` forms.

*Please refer to the [README.ru.md](README.ru.md) file for instructions in Russian.*

## Installation

Add it to your Gemfile:

```ruby
gem 'bemer-simple_form'
```

Run the following command to install it:

    $ bundle

## Configuration
### `bemer-simple_form` configuration
Default configuration:
```ruby
# config/initializers/bemer_simple_form.rb
Bemer::SimpleForm.setup do |config|
  config.bemify_namespaces                   = %i[error hint input wrapper label]
  config.element_name_transformer            = nil # lambda {  |namespace, block, namespaced_elem, initial_elem| ... }
  config.input_type_modifiers_for_namespaces = %i[input wrapper label]
end
```

### `bemer` configuration
The default configuration is available [here](https://github.com/vill/bemer/blob/master/docs/%D0%9A%D0%BE%D0%BD%D1%84%D0%B8%D0%B3%D1%83%D1%80%D0%B0%D1%86%D0%B8%D1%8F.md).
```ruby
# config/initializers/bemer.rb
Bemer.setup do |config|
  config.bem                      = true
  config.element_name_separator   = '__'
  config.modifier_name_separator  = '--'
  config.modifier_value_separator = '_'
end
```

### `simple_form` configuration

To disable the creation of unnecessary `CSS` classes from `SimpleForm`, just change the following configuration parameters:
```ruby
# config/initializers/simple_form.rb
SimpleForm.setup do |config|
  config.wrappers :default do |b|
    # ...

    # Inputs
    b.use :hint,  wrap_with: { tag: :span }
    b.use :error, wrap_with: { tag: :span }

    # ...
  end

  # ...

  # DEPRECATED: You can define the class to be used on all forms.
  config.form_class = nil

  # Default class for buttons
  config.button_class = nil

  # CSS class to add for error notification helper.
  config.error_notification_class = nil

  # You can define which elements should obtain additional classes.
  config.generate_additional_classes_for = []

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = nil

  # Defines if the default input wrapper class should be included in radio collection wrappers.
  config.include_default_input_wrapper_class = false

  # ...
end
```

Additionally, you can specify `class: nil`:
```slim
= simple_form_for resource, url: registration_path(resource_name), html: { class: nil } do |f|
  / ...
```
## Usage

For `simple_form_for`, the same parameters are available as for [the `block_tag` helper](https://github.com/vill/bemer/blob/master/docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-block_tag.md).

The same parameters are available for form elements as for [`block_tag` helper](https://github.com/vill/bemer/blob/master/docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-block_tag.md#%D0%BF%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80-content) elements created using `content` passed as Ruby `&block`.

Creating a form with default parameters:

```slim
= simple_form_for resource, url: registration_path(resource_name), html: { class: nil } do |f|
  = f.input :email, required: true, autofocus: true
  = f.input :password, required: true, input_html: { autocomplete: 'off' }
  = f.input :password_confirmation, required: true, input_html: { autocomplete: 'off' }
  => f.button :submit, t('.sign_up')
```

The name of the block is passed through the `as` parameter:
```slim
= simple_form_for resource, as: :user, url: registration_path(resource_name), html: { class: nil } do |f|
  = f.input :email, required: true, autofocus: true
  = f.input :password, required: true, input_html: { autocomplete: 'off' }
  = f.input :password_confirmation, required: true, input_html: { autocomplete: 'off' }
  = f.button :submit, t('.sign_up')
```

The name of the block is passed through the `block` parameter:
```slim
= simple_form_for resource, block: :user, url: registration_path(resource_name), html: { class: nil } do |f|
  = f.input :email, required: true, autofocus: true
  = f.input :password, required: true, input_html: { autocomplete: 'off' }
  = f.input :password_confirmation, required: true, input_html: { autocomplete: 'off' }
  = f.button :submit, t('.sign_up')
```

Add the `enabled` modifier to the `email` element:
```slim
= simple_form_for resource, block: :user, url: registration_path(resource_name), html: { class: nil } do |f|
  = f.input :email, required: true, autofocus: true, input_html: { mods: :enabled }
  = f.input :password, required: true, input_html: { autocomplete: 'off' }
  = f.input :password_confirmation, required: true, input_html: { autocomplete: 'off' }
  = f.button :submit, t('.sign_up')
```

The result of rendering a form with default parameters:
```html
<form id="new_admin_user" novalidate="novalidate" class="admin-user" action="/user" accept-charset="UTF-8" method="post">
  <input type="hidden" name="authenticity_token" value="dXgQo5PvtM5g01pFiQmpMDTb8BYVxsMvzS8n+6YN/UhjFR/tCf4ym7bZzMgs/E/ECxvXZcbr9uzMPcUUIj43jA==">
  <div class="admin-user__email-wrapper admin-user__email-wrapper--email admin-user__email-wrapper--required">
    <label class="admin-user__email-label admin-user__email-label--email admin-user__email-label--required" for="admin_user_email">
      <abbr title="Обязательное">*</abbr>
      Электронный адрес
    </label>
    <input autofocus="autofocus" class="admin-user__email admin-user__email--email admin-user__email--required" required="required" aria-required="true" type="email" value="" name="admin_user[email]" id="admin_user_email">
  </div>
  <div class="admin-user__password-wrapper admin-user__password-wrapper--password admin-user__password-wrapper--required">
    <label class="admin-user__password-label admin-user__password-label--password admin-user__password-label--required" for="admin_user_password">
      <abbr title="Обязательное">*</abbr>
      Пароль
    </label>
    <input autocomplete="off" class="admin-user__password admin-user__password--password admin-user__password--required" required="required" aria-required="true" type="password" name="admin_user[password]" id="admin_user_password">
  </div>
  <div class="admin-user__password-confirmation-wrapper admin-user__password-confirmation-wrapper--password admin-user__password-confirmation-wrapper--required">
    <label class="admin-user__password-confirmation-label admin-user__password-confirmation-label--password admin-user__password-confirmation-label--required" for="admin_user_password_confirmation">
      <abbr title="Обязательное">*</abbr>
      Подтверждение пароля
    </label>
    <input autocomplete="off" class="admin-user__password-confirmation admin-user__password-confirmation--password admin-user__password-confirmation--required" required="required" aria-required="true" type="password" name="admin_user[password_confirmation]" id="admin_user_password_confirmation">
  </div>
  <input type="submit" name="commit" value="Зарегистрироваться" class="admin-user__submit" data-disable-with="Зарегистрироваться">
</form>
```
The result of rendering a form containing validation errors:
```html
<form novalidate="novalidate" class="admin-user" action="/user" accept-charset="UTF-8" method="post">
  <input type="hidden" name="authenticity_token" value="5GJ9rIPD1XVg8BDKy2ZBpDt3qYlBuAh/z7u00qw8bzfyD3LiGdJTILb6hkduk6dQBLeO+pKVPbzOqVY9KA+l8w==">
  <div class="admin-user__email-wrapper admin-user__email-wrapper--email admin-user__email-wrapper--required">
    <label class="admin-user__email-label admin-user__email-label--email admin-user__email-label--required" for="admin_user_email">
      <abbr title="Обязательное">*</abbr>
      Электронный адрес
    </label>
    <input autofocus="autofocus" class="admin-user__email admin-user__email--email admin-user__email--required" required="required" aria-required="true" aria-invalid="true" type="email" value="" name="admin_user[email]" id="admin_user_email">
    <span class="admin-user__email-error">не может быть пустым</span>
  </div>
  <div class="admin-user__password-wrapper admin-user__password-wrapper--password admin-user__password-wrapper--required">
    <label class="admin-user__password-label admin-user__password-label--password admin-user__password-label--required" for="admin_user_password">
      <abbr title="Обязательное">*</abbr>
      Пароль
    </label>
    <input autocomplete="off" class="admin-user__password admin-user__password--password admin-user__password--required" required="required" aria-required="true" aria-invalid="true" type="password" name="admin_user[password]" id="admin_user_password">
    <span class="admin-user__password-error">не может быть пустым</span>
  </div>
  <div class="admin-user__password-confirmation-wrapper admin-user__password-confirmation-wrapper--password admin-user__password-confirmation-wrapper--required">
    <label class="admin-user__password-confirmation-label admin-user__password-confirmation-label--password admin-user__password-confirmation-label--required" for="admin_user_password_confirmation">
      <abbr title="Обязательное">*</abbr>
      Подтверждение пароля
    </label>
    <input autocomplete="off" class="admin-user__password-confirmation admin-user__password-confirmation--password admin-user__password-confirmation--required" required="required" aria-required="true" type="password" name="admin_user[password_confirmation]" id="admin_user_password_confirmation">
  </div>
  <input type="submit" name="commit" value="Зарегистрироваться" class="admin-user__submit" data-disable-with="Зарегистрироваться">
</form>
```
## Links

1. BEM methodology - https://en.bem.info/methodology
1. Minimal stack for coding client-side JavaScript and templating - https://github.com/bem/bem-core
1. Declarative template engine for the browser and server with regular JS syntax - https://github.com/bem/bem-xjst

## License

Copyright (c) 2019-2020 Alexander Grigorev. See [LICENSE.txt](LICENSE.txt) for further details.
