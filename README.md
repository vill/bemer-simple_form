# Использование соглашений из БЭМ методологии в формах Simple Form

## Установка

Добавить в `Gemfile`:

```ruby
gem 'bemer-simple_form'
```

Выполнить в терминале команду:

    $ bundle

## Настройки
### Конфигурация `bemer-simple_form`
Параметры конфигурации по умолчанию:
```ruby
# config/initializers/bemer_simple_form.rb
Bemer::SimpleForm.setup do |config|
  config.bemify_namespaces                   = %i[error hint input wrapper label]
  config.input_type_modifiers_for_namespaces = %i[input wrapper label]
end
```

### Конфигурация `bemer`
Все параметры конфигурации использующие по умолчанию досутпны [здесь](https://github.com/vill/bemer/blob/master/docs/%D0%9A%D0%BE%D0%BD%D1%84%D0%B8%D0%B3%D1%83%D1%80%D0%B0%D1%86%D0%B8%D1%8F.md).
```ruby
# config/initializers/bemer.rb
Bemer.setup do |config|
  config.bem                      = true
  config.element_name_separator   = '__'
  config.modifier_name_separator  = '--'
  config.modifier_value_separator = '_'
end
```

### Конфигурация `simple_form`
Для того, чтобы отключить генерацию ненужных CSS классов от Simple Form, достаточно изменить следующие параметры конфигурации:
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
Дополнительно при вызове можно указать `class: nil`:
```slim
= simple_form_for resource, url: registration_path(resource_name), html: { class: nil } do |f|
  / ...
```
## Использование

Для `simple_form_for` доступны такие же параметры как и для [хелпера `block_tag`](https://github.com/vill/bemer/blob/master/docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-block_tag.md).

Для элементов формы доступны такие же параметры как и для элементов [хелпера `block_tag`](https://github.com/vill/bemer/blob/master/docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-block_tag.md#%D0%BF%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80-content) создаваемых с помощью `content`, переданного в виде Ruby `&block`.

Создание формы с параметрами по умолчанию:

```slim
= simple_form_for resource, url: registration_path(resource_name), html: { class: nil } do |f|
  = f.input :email, required: true, autofocus: true
  = f.input :password, required: true, input_html: { autocomplete: 'off' }
  = f.input :password_confirmation, required: true, input_html: { autocomplete: 'off' }
  => f.button :submit, t('.sign_up')
```

Название блока передается через параметр `as`:
```slim
= simple_form_for resource, as: :user, url: registration_path(resource_name), html: { class: nil } do |f|
  = f.input :email, required: true, autofocus: true
  = f.input :password, required: true, input_html: { autocomplete: 'off' }
  = f.input :password_confirmation, required: true, input_html: { autocomplete: 'off' }
  = f.button :submit, t('.sign_up')
```

Название блока передается через параметр `block`:
```slim
= simple_form_for resource, block: :user, url: registration_path(resource_name), html: { class: nil } do |f|
  = f.input :email, required: true, autofocus: true
  = f.input :password, required: true, input_html: { autocomplete: 'off' }
  = f.input :password_confirmation, required: true, input_html: { autocomplete: 'off' }
  = f.button :submit, t('.sign_up')
```

Добавить модификатор `enabled` в элемент `email`:
```slim
= simple_form_for resource, block: :user, url: registration_path(resource_name), html: { class: nil } do |f|
  = f.input :email, required: true, autofocus: true, input_html: { mods: :enabled }
  = f.input :password, required: true, input_html: { autocomplete: 'off' }
  = f.input :password_confirmation, required: true, input_html: { autocomplete: 'off' }
  = f.button :submit, t('.sign_up')
```

Результат рендеринга формы с параметрами по умолчанию:
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
Результат рендеринга формы содержащей ошибки валидации:
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
## Ссылки

1. https://ru.bem.info/methodology/
1. https://github.com/bem/bem-xjst
1. https://github.com/bem/bem-core

## Лицензия

Copyright (c) 2019 - 2020 Александр Григорьев. Более подробную информацию о лицензии можно получить в файле [LICENSE-RU.txt](LICENSE-RU.txt).
